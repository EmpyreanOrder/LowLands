//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using DeepSpaceLabs.Core;
    using System;
    using System.Collections.Generic;
    using Unity.Collections;
    using Unity.Jobs;
    using UnityEngine;
    using UnityEngine.AddressableAssets;
    using UnityEngine.ResourceManagement;
    using UnityEngine.ResourceManagement.AsyncOperations;
    using UnityEngine.ResourceManagement.ResourceLocations;

    /// <summary>
    /// Base class for addressable chunk streamer implementations. While it is not strictly necessary to use this with your custom addressable 
    /// chunk streamers, doing so will automate many necessary task related to loading addressable assets.
    /// <para>
    /// The only thing you need to provide implementations for is the FileExtension property, the DetatchAndUnloadChunksFromCells method, 
    /// and a custom AddressableStreamerBaseUser object, which should be returned in your implementation of the CreateAddressableLoaderUser method.
    /// </para>
    /// <para>
    /// Furthermore, your custom AddressableStreamerBaseUser must implement certain methods and properties.
    /// </para>
    /// </summary>
    public abstract class AddressableBaseChunkStreamer : ChunkStreamer
    {
        #region Inspector Fields

        [SerializeField, FieldRename("Default Max Chunks To\nConfigure In A Single Frame", "Default Max Chunks To Configure In A Single Frame\n\nThe default maximum number of Asset Chunks that can be configured in a single frame.\n\nThis value is important, especially for the Addressable Prefab Chunk Streamer, as configuration involves the instantiation of the source addressable asset to create a copy that can be used in game, which can be a heavy operation. Careful profiling must be done to find a value that works well, though note that smaller values will slow down the World's update speed.\n\nFor scenes, there is much less configuration work, as the loading of the scene via the async load op does most of the work, and most of the performance penalty is paid in the completion of the loading op, so larger values can and should be used.\n\nThis value serves as a default value which Addressable Chunk Streamers can use, however you can also set this value on a per LOD Group basis using the Streamable Grid's Extra Data feature.\n\nTo use this, simply provide a key corresponding to the extra data, then add an entry to your Streamable Grid's Global Extra Data or LOD Group's Extra Data that uses this key, and store the max chunks to configure in a single frame value in its Data field (should be an integer value!).\n\nA value of 0 is special and tells the Streamer there is no limit on the number of chunks that can be configured in a single frame.")]
        int defaultMaxChunksToConfigureInSingleFrame = 5;

        [SerializeField, FieldRename("Max Chunks To Configure Key*", "Max Chunks To Configure Key\n\nThe key to use to try and retrieve the Max Chunks To Configure In a Single Frame value for each LOD Group. The extra data can be stored in the Streamable Grid assets Global Extra Data (which means it will apply to all LOD Groups on that Grid), or to an individual LOD Group's Extra Data.\n\nIf the key is not valid for an LOD Group, there is no harm; the 'Default Chunks To Configure In A Single Frame' value will be used for that LOD Group.")]
        string maxChunksToConfigureKey = "Max Chunks To Release";

        [SerializeField, FieldRename("Default Max Async Handles To\nRelease In A Single Frame", "Default Max Async Handles To Release In A Single Frame\n\nThe default maximum number of Async Operation Handles that can be released in a single frame.\n\nThis value is important, as releasing the handle can be time consuming work on the main thread.\n\nThis value serves as a default value which Addressable Chunk Streamers can use, however all of the built in Addressable Chunk Streamer implementations allow for setting this value on a per LOD Group basis using the Streamable Grid's Extra Data feature.\n\nTo use this, simply provide a key corresponding to the extra data, then add an entry to your Streamable Grid's Global Extra Data or LOD Group's Extra Data that uses this key, and store the max async op handles to release in a single frame value in its Data field (should be an integer value!).\n\nA value of 0 is special and tells the Streamer there is no limit on the number of async operation handles that can be released in a single frame.")]
        int defaultMaxAsyncHandlesToReleaseInSingleFrame = 5;

        [SerializeField, FieldRename("Max Async Handles\nTo Release Key*", "Max Async Handles To Release Key\n\nThe key to use to try and retrieve the Max Async Handles To Release In a Single Frame value for each LOD Group. The extra data can be stored in the Streamable Grid assets Global Extra Data (which means it will apply to all LOD Groups on that Grid), or to an individual LOD Group's Extra Data.\n\nIf the key is not valid for an LOD Group, there is no harm; the 'Default Max Async Handles To Release In A Single Frame' value will be used for that LOD Group.")]
        string maxAsyncHandlesReleaseKey = "Max Async Handles To Release";

        [SerializeField, FieldRename("Pre Calculate\nIResourceLocations*", "Pre Calculate IResourceLocations\n\nIf disabled, when loading an addressable asset, the streamer will pass in the name of the asset (with the sub folder path prepended if present) upon each load request. This will likely produce a bit of garbage for the string generation and also incurs a small performance hit, as the Addressable system uses this key to find the appropriate IResourceLocation for the asset.\n\nEnabling this option will have the streamer precalculate these IResourceLocations, which will both eliminate the string generated garbage and speed up the loading process (by how much, we don't know. Please feel free to test!). There is a cost, however, as the IResourceLocation objects need to be stored, so for large worlds with many enabled cells, the storage cost may be too high.\n\nIf for some reason the load path changes or you need to retrieve assets from a different location, you can recalulcate the IResourceLocations by calling the RecalculateIResourceLocations method.")]
        bool preCalculateIResourceLocations = false;

        [SerializeField, FieldRename("Prepend Extra User Data*", "Prepend Extra User Data\n\nIf enabled, the streamer will attempt to prepend specific string data from each user to the generated string used to load the chunk for each cell.\n\nThis may be necessary if you have a folder path included in the addresses of your addressable assets.\n\nFor example, if your assets are formatted like Assets/MyAssets/SomeSubFolder/Terrain_1_1.prefab (or Terrain_1_2.prefab, etc), the streamer will need to prepend 'Assets/MyAssets/SomeSubFolder/' to the beginning of each chunk name in order to load it correctly.\n\nThe data that is prepended to each name is not constant, but instead is retrieved from the Streamable Grid associated with each user. This data must be added either to the Streamable Grid's Global Extra Data section, or to a particular LOD's Extra Data section. This data is stored using a unique key, which you can provide in the 'Prepend Data Key' field.\n\nNote that since the streamer can only use a single key, all users of this streamer that wish to prepend data must use that same key to store the prepended string data.\n\nIf the same key is used to store data in both the Streamable Grid's Global Extra Data and in the LOD associated with the user's Extra Data, the data from the LOD is always used. This allows you to provide global data for all LODs, then override that data on a per LOD basis if needed.\n\nIf data is not found using the key for a particular user, then the streamer will not prepend anything to the generated chunk names for that user.")]
        bool prependExtraUserData = false;

        [SerializeField, FieldRename("Prepend Data Key", "Prepend Data Key\n\nThe key used to retrieve the data that will be prepended to the generated chunk names. While each user can possess different data to prepend, the key used to store the data must be the same for all users.\n\nNote that a user refers to a specific LOD of a specific Streamable Grid. You can store this prepend data for all LODs on the Streamable Grid by storing it in the Global Extra Data section, or store in for a specific LOD by storing it in that LOD's Extra Data section. You can also use both methods, in which case the data stored in the LOD will take priority and be used.\n\nPlease hover over the Prepend Extra User Data field label to see more information about what the prepend data is used for.")]
        string prependDataKey = "Addressable Path";

        [SerializeField, FieldRename("Append Extra User Data*", "Append Extra User Data\n\nIf enabled, the streamer will attempt to append specific string data from each user to the generated string used to load the chunk for each cell.\n\nThe most likely use case for using this option is if you have a file extension included in the addresses of your addressable assets, as the streamer usually will not be able to load the assets without this file extension.\n\nIt should be noted however, that there is another option available to append the file extension on this streamer, called 'Append File Extension'. This will append a file extension returned by the implmentation of the Addressable Base Chunk Streamer. For the included Prefab and Scene Loaders, this file extension is .prefab and .unity respectively.\n\nHowever, this will not work if some of your addressable assets include the file extension and others do not, as the streamer will add the file extension to all asset names.\n\nRather than create separate streamer for the different types of assets in this case, a better option is to add the file extensions as extra data on a per user/LOD basis. This data must be added either to the Streamable Grid's Global Extra Data section, or to a particular LOD's Extra Data section. This data is stored using a unique key, which you can provide in the 'Append Data Key' field.\n\nNote that since the streamer can only use a single key, all users of this streamer that wish to append data must use that same key to store the appended string data.\n\nIf the same key is used to store data in both the Streamable Grid's Global Extra Data and in the LOD associated with the user's Extra Data, the data from the LOD is always used. This allows you to provide global data for all LODs, then override that data on a per LOD basis if needed.\n\nIf data is not found using the key for a particular user, then the streamer will not not append anything to the generated names for that user.")]
        bool appendExtraUserData = false;

        [SerializeField, FieldRename("Append Data Key", "Append Data Key\n\nThe key used to retrieve the data that will be appended to the generated chunk names. While each user can possess different data to append, the key used to store the data must be the same for all users.\n\nNote that each user is associated with a specific LOD of a specific Streamable Grid. You can store this append data for all LODs on the Streamable Grid by storing it in the Global Extra Data section, or store in for a specific LOD by storing it in that LOD's Extra Data section. You can also use both methods, in which case the data stored in the LOD will take priority and be used.\n\nPlease hover over the Append Extra User Data field label to see more information about what the appended data is used for.")]
        string appendDataKey = "File Extension";

        [SerializeField, FieldRename("Append File Extension*", "Append File Extension\n\nWhen enabled, the file extension pulled from the Addressable Base Chunk Streamer implementation will be appeneded to the key (after any extra user data to append if used) for each chunk of each cell loaded uisng this Addressable Streamer, in order to form the full address of each asset. If using an Addressable Prefab Chunk Streamer, the extension is '.prefab'. If using the Addressable Scene Chunk Streamer, the extension is '.unity'.\n\nEnabling this option should only be necessary when the file type appears in the Addressable Assets Address field.\n\nIf the addresses of the LODs using this streamer are inconsistent (that is, some have the file extension while others do not), you won't be able to use this option. Instead use the 'Append Extra User Data' option, which you can read more about by hovering over that field name.")]
        bool appendFileExtension = true;

        [SerializeField, FieldRename("Max Load Attempts*", "Max Load Attempts\n\nThe maximum number of times to try load an addressable asset before accepting defeat and moving on to the error handling phase. Setting to 1 will mean the streamer immediately moves on to error handling after 1 failed attempt.\n\nOnce Max Load Attempts is reached, the streamer will try and repair load errors using an Addressable Error Repairer (if provided). Successfull repairs will cause associated assets to be redownloaded. If that fails or if the repairs are unsuccessfull, fail-safe assets are loaded instead (if fail-safe assets are enabled). Finally, an exception is thrown if an asset cannot be loaded for a chunk.")]
        int maxLoadAttempts = 3;

        [SerializeField, FieldRename("Error Repairer*", "Error Repairer\n\nIf provided, after reaching max load attempts, the streamer will call the Addressable Error Repairer's AttemptRepair method in order to try and repair the issues that caused the failed downloads.\n\nAny load operations with errors that are repaired will be redownloaded again.\n\nIf repairs fail, or if a download fails after a repair has been successfull, the streamer will move on to either loading a fail-safe asset or throwing an exception.\n\nYou must create a class that derives from AddressableErrorRepairer in order to use this functionality. Please take a look at AddressableErrorRepairer.cs file in the Assets/Deep Space Labs/SAM/Scripts/AddressableDependent/RuntimeCode folder for information on what is expected of this class.")]
        AddressableErrorRepairer errorRepairer;

        [SerializeField, FieldRename("Use Alt LOD Fail-Safe*", "Use Alt LOD Fail-Safe\n\nIf enabled, whenever a fail-safe asset is needed, the streamer will attempt to load the lowest quality LOD asset associated with a given cell. The streamer will either attempt to load a place holder asset (if 'Use Placeholder Fail Safe' is enabled) or throw and exception under the following circumstances.\n\n1) If the fail-safe asset is needed for a World Cell already associated with the lowest quality LOD.\n\n2) If the loading of this fail-safe asset fails.\n\n3) If the cell is associated with a Streamable Grid that contains a single LOD.\n\n4) If the lowest quality LOD does not make use of a Addressable Chunk Streamer (must be same as this components type).\n\nAlso keep in mind the following points:\n\n1) When using an Addressable Prefab Chunk Streamer, once the lowest quality LOD asset is loaded for a given chunk on a World Cell, any subsequent World Cells that need the same chunk asset will utilize the lowest quality LOD asset, until all World Cells using the LOD asset are unloaded. After that, the streamer will attempt to load the original chunk asset again the next time it is needed.\n\nThis is not true when using the scene streamer because each chunk requires a separate addressable scene asset, therefore every load call will attempt to load the original chunk asset.\n\n2) In order to ensure the lowest quality LOD asset is loadable, it should be placed in a special group whose bundles are stored on the players device rather than on a remote server.\n\n3) When the lowest quality LOD asset is used, other components that have a reference to the World Cell will still expect the World Cell as a whole to be the original LOD. This may cause issues if the lowest quality LOD asset does not have the same hierarchy or does not have the same components as the correct LOD assets. If this is a potential problem for you, you can query the World Cell's AllChunkAssetsMatchExpectedLOD property to ensure all chunks have assets that match the cell's LOD. If this value is false, you will need to check each chunk game objects hiearchy (or use some other means) to determine which asset it is.\n\nHowever, a better strategy would be to ensure your components work with any asset by making sure there hierarchies/components are consistent, so that you do not need to worry about differences in assets.")]
        bool useAltLODFailSafe = false;

        [SerializeField, FieldRename("Use Placeholder Fail-Safe*", "Use Placeholder Fail-Safe\n\nIf enabled, whenever a fail-safe asset is needed and 'Use Alt LOD Fail Safe' is disabled or the alt LOD asset cannot be loaded, the streamer will attempt to load a placeholder asset instead, and if that fails, throw and exception. Keep the following points in mind:\n\n1)The placeholder asset must contain the prepended/appended data (if applicable) and group name. The name of the asset must be 'GroupName_Placeholder', where GroupName is the name shared by all assets on the given LOD.\n\n2) The type of addressable placeholder asset the streamer expects to find (prefab or scene) is based on whether the streamer is a Prefab Streamer or Scene Streamer.\n\n3) When using a Prefab Streamer, once a placeholder asset is loaded for a given chunk on a given World Cell, any subsequent cells that need an asset for the same chunk will utilize the placeholder asset, until all World Cells using the placeholder are unloaded. After that, the streamer will attempt to load the original asset again the next time it is needed.\n\nThis is not true when using the scene streamer because each chunk requires a separate addressable scene asset, therefore every load call will attempt to load the original chunk asset.\n\n4) In order to ensure the placeholder asset is loadable, it should be placed in a special group whose bundles are stored on the players device rather than on a remote server.\n\n5) When the placeholder asset is used, other components that have a reference to the World Cell will still expect the World Cell as a whole to be the original LOD. This may cause issues if the placeholder asset does not have the same hierarchy or does not have the same components as the correct LOD assets. If this is a potential problem for you, you can check the World Cell's AllChunkAssetsMatchExpectedLOD to ensure all chunks have assets that match the cell's LOD. If this value is false, you will need to check each chunk game objects hiearchy (or use some other means) to determine which asset it is.\n\nHowever, a better strategy would be to ensure your components work with any asset by making sure there hierarchies/components are consistent, so that you do not need to worry about differences in assets.\n\n6)Each LOD that uses the streamer must have its own Placeholder asset!")]
        bool usePlaceholderFailSafe = false;

        [SerializeField, FieldRename("Print Error To Console*", "Print Error To Console\n\nIf enabled, whenever an addressable asset cannot be loaded, the exception provided by Unity for the download error is printed to the console as an error. The only time this will not occur is when an exception is to be thrown by the streamer.")]
        bool printErrorToConsole = true;

        [SerializeField, FieldRename("Exception Handler*", "Exception Handler\n\nBy default, when Log Runtime Exceptions is enabled in your Addressable Settings, the streamer will assign a default method to ResourceManager.ExceptionHandler. This default method only logs Invalid Key Exceptions. If you would like to log other exceptions, or perform custom logic when an exception occurs, you can create a custom class deriving from AddressableExceptionHandler, add it to the scene, and assign it to this field.")]
        AddressableExceptionHandler addressableExceptionHandler;


        #endregion

        #region Non Inspector Fields
        [NonSerialized]
        ConditionalMembers conditionalMembers;
        protected AsyncLoadStrategy lastStrategyUsed;
        List<string> reusableStringList;

        //all addressable streamer instances can use the same pools
        static SelfCreatingPool<List<AsyncOperationHandle>> handleListPool;
        static SelfCreatingPool<List<bool>> boolListPool;
        static SelfCreatingPool<WaitingOp> waitingOpPool;
        static SelfCreatingPool<LoadingOp> loadingOpPool;
        static SelfCreatingPool<ReadyOp> readyOpPool;
        static SelfCreatingPool<LoadedAsyncOperationInfo> loadedAsyncOpInfoPool;
        #endregion

        #region Properties

        /// <summary>
        /// See <see cref="ChunkStreamer.ExtraDataToPrependKey" href="ChunkStreamer.html#ExtraDataToPrependKey">ChunkStreamer.ExtraDataToPrependKey</see> 
        /// for more information on this property. This implemention simply returns the value 
        /// of 'Prepend Data Key' set in the inspector if 'Prepend Extra User Data' is true, or null if 'Prepend Extra User Data' is false.
        /// </summary>
        /// <type>string</type>
        public sealed override string ExtraDataToPrependKey { get { return prependExtraUserData ? prependDataKey : null; } }

        /// <summary>
        /// See <see cref="ChunkStreamer.ExtraDataToAppendKey" href="ChunkStreamer.html#ExtraDataToAppendKey">ChunkStreamer.ExtraDataToAppendKey</see> 
        /// for more information on this property. This implemention simply returns the value 
        /// of 'Append Data Key' set in the inspector if 'Append Extra user Data' is true, or null if 'Prepend Extra User Data' is false.
        /// </summary>
        /// <type>string</type>
        public sealed override string ExtraDataToAppendKey { get { return appendExtraUserData ? appendDataKey : null; } }

        /// <summary>
        /// Returns the <see cref="FileExtension" href="AddressableBaseChunkStreamer.html#FileExtension">FileExtension</see> 
        /// if Append File Extension is enabled in the inspector, otherwise returns null.
        /// </summary>
        /// <type>string</type>
        public sealed override string ConstantDataToAppend { get { return appendFileExtension ? FileExtension : null; } }

        /// <summary>
        /// Override to return the file extension associated with the addressable assets being loaded. You can override this to try and load custom asset types, such as 
        /// scriptable objects, however there is no gaurantee that this will work. This is used when Append File Type is enabled in the inspector.
        /// <para>
        /// For Prefabs this is .prefab, for scenes it is .unity
        /// </para>
        /// </summary>
        protected abstract string FileExtension { get; }

        /// <summary>
        /// Gets or sets the Async Load Strategy. 
        /// </summary>
        /// <type link="AsyncLoadStrategy.html">AsyncLoadStrategy</type>
        public AsyncLoadStrategy AsyncLoadStrategy { get { return AsyncLoadStrategy.AllTogether; } }

        /// <summary>
        /// Gets or sets the maximum number of attempts allowed for loading an asset.
        /// </summary>
        public int MaxLoadAttempts { get { return maxLoadAttempts; } set { maxLoadAttempts = value; } }

        /// <summary>
        /// Whether the streamer has been configured to a use a lowest quality LOD fail-safe asset when the original asset  
        /// cannot be loaded for a cell chunk.
        /// </summary>
        /// <type>bool</type>
        public bool UseAltLODFailSafe { get { return useAltLODFailSafe; } }

        /// <summary>
        /// Whether the streamer has been configured to a use a placeholder fail-safe asset when the original asset (or lowest quality LOD asset) 
        /// cannot be loaded for a cell chunk.
        /// </summary>
        /// <type>bool</type>
        public bool UsePlaceholderFailSafe { get { return usePlaceholderFailSafe; } }

        /// <summary>
        /// When FailureHandling is set to LoadPlaceholder, this controls whether the exception reported by Unity for the failed load operation is 
        /// printed as an error in the console. 
        /// </summary>
        /// <type>bool</type>
        public bool PrintErrorToConsole { get { return printErrorToConsole; } set { printErrorToConsole = value; } }

        /// <summary>
        /// Gets the Addressable Error Repairer associated with the Addressable Streamer.
        /// </summary>
        /// <type link="AddressableErrorRepairer.html">AddressableErrorRepairer</type>
        public AddressableErrorRepairer ErrorRepairer { get { return errorRepairer; } }

        SelfCreatingPool<List<AsyncOperationHandle>> HandleListPool { get { return handleListPool; } }
        SelfCreatingPool<List<bool>> BoolListPool { get { return boolListPool; } }

        public void UpdateDefaultMaxChunksToConfigureInSingleFrame(int newValue)
        {
            defaultMaxChunksToConfigureInSingleFrame = newValue;
            foreach (var user in RegisteredUsers.RegistrantEntries())
                ((AddressableStreamerBaseUser)user).SetMaxChunksToConfigureInSingleFrame();
        }

        public void UpdateDefaultMaxAsyncHandlesToReleaseInSingleFrame(int newValue)
        {
            defaultMaxAsyncHandlesToReleaseInSingleFrame = newValue;
            foreach (var user in RegisteredUsers.RegistrantEntries())
                ((AddressableStreamerBaseUser)user).SetMaxAsyncHandlesToReleaseInSingleFrame();
        }

        #endregion

        #region Standard Methods

        /// <summary>
        /// Awake implementation. If you want to implement custom Awake logic, implement AwakeExtended2.
        /// </summary>
        /// <displayName id="AwakeExtended">
        /// AwakeExtended()
        /// </displayName>
        /// <syntax>
        /// protected void AwakeExtended()
        /// </syntax>
        protected sealed override void AwakeExtended()
        {
            conditionalMembers = ConditionalMembers.GetConditionalMembers();
            ReusableEnumerators.AddUser<AddressablesLoadAndAttachCellsEnumerator>();

            if (maxLoadAttempts < 1)
            {
                Debug.LogWarning("Max Load Attemps must be 1 or greater. Setting to 1");
                maxLoadAttempts = 1;
            }

            if (handleListPool == null)
                handleListPool = new SelfCreatingPool<List<AsyncOperationHandle>>(() => new List<AsyncOperationHandle>());

            if (boolListPool == null)
                boolListPool = new SelfCreatingPool<List<bool>>(() => new List<bool>());

            if (loadingOpPool == null)
                loadingOpPool = new SelfCreatingPool<LoadingOp>(() => new LoadingOp());

            if (waitingOpPool == null)
                waitingOpPool = new SelfCreatingPool<WaitingOp>(() => new WaitingOp());

            if (readyOpPool == null)
                readyOpPool = new SelfCreatingPool<ReadyOp>(() => new ReadyOp());

            if (loadedAsyncOpInfoPool == null)
                loadedAsyncOpInfoPool = new SelfCreatingPool<LoadedAsyncOperationInfo>(() => new LoadedAsyncOperationInfo());

            AwakeExtended2();
        }

        /// <summary>
        /// Can be overriden to implement Awake related logic. Called at end of base classes AwakeExtended method.
        /// </summary>
        /// <displayName id="AwakeExtended2">
        /// AwakeExtended2()
        /// </displayName>
        /// <syntax>
        /// protected virtual void AwakeExtended2()
        /// </syntax>
        protected virtual void AwakeExtended2() { }

        /// <summary>
        /// Awake implementation. If you want to implement custom Start logic, implement StartExtended.
        /// </summary>
        /// <displayName id="Start">
        /// Start()
        /// </displayName>
        /// <syntax>
        /// protected void Start()
        /// </syntax>
        protected void Start()
        {
            if (addressableExceptionHandler != null)
                ResourceManager.ExceptionHandler = addressableExceptionHandler.HandleException;
            else
                ResourceManager.ExceptionHandler = DefaultCustomExceptionHandler;
            StartExtended();
        }

        /// <summary>
        /// Can be overriden to implement Start related logic. Called at end of base classes Start method.
        /// </summary>
        /// <displayName id="StartExtended">
        /// StartExtended()
        /// </displayName>
        /// <syntax>
        /// protected virtual void StartExtended()
        /// </syntax>
        protected virtual void StartExtended() { }

        void DefaultCustomExceptionHandler(AsyncOperationHandle handle, Exception exception)
        {
            if (exception.GetType() == typeof(InvalidKeyException))
                Addressables.LogException(handle, exception);
        }

        /// <summary>
        /// OnDestroy implementation. If you want to implement custom OnDestroy logic, implement OnDestroyExtended.
        /// </summary>
        /// <displayName id="OnDestroy">
        /// OnDestroy()
        /// </displayName>
        /// <syntax>
        /// protected void OnDestroy()
        /// </syntax>
        protected void OnDestroy()
        {
            ReusableEnumerators.RemoveUser<AddressablesLoadAndAttachCellsEnumerator>();
            OnDestroyExtended();
        }

        /// <summary>
        /// Can be overriden to implement OnDestroy related logic. Called at end of base classes OnDestroy method.
        /// </summary>
        /// <displayName id="OnDestroyExtended">
        /// OnDestroyExtended()
        /// </displayName>
        /// <syntax>
        /// protected virtual void OnDestroyExtended()
        /// </syntax>
        protected virtual void OnDestroyExtended() { }


        /// <summary>
        /// Creates a new ChunkStreamerUser by calling CreateAddressableLoaderUser. This method is overriden to force sub classes 
        /// to create a new ChunkStreamerUser that derives from AddressableLoaderBaseUser. This is necessary because 
        /// AddressableLoaderBaseUser is an abstract class and some of its methods/properties need to be implemented.
        /// </summary>
        /// <param name="zoneLODGroup" type="IZoneLODGroup" link="IZoneLODGroup.html">
        /// The Zone LOD Group being registered.
        /// </param>
        /// <returns type="ChunkStreamerUser" link="ChunkStreamerUser.html">
        /// A new user object created using the zone LOD Group as input.
        /// </returns>
        /// <displayName id="CreateNewUser">
        /// CreateNewUser(IZoneLODGroup)
        /// </displayName>
        /// <syntax>
        /// protected sealed override ChunkStreamerUser CreateNewUser(IZoneLODGroup zoneLODGroup)
        /// </syntax>
        protected sealed override ChunkStreamerUser CreateNewUser(IZoneLODGroup zoneLODGroup)
        {
            return CreateAddressableLoaderUser(zoneLODGroup);
        }

        /// <summary>
        /// Override to return a new user object that derives from AddressableStreamerBaseUser. The derived class must implement certain 
        /// abstract methods/properties from AddressableStreamerBaseUser.
        /// </summary>
        /// <param name="zoneLODGroup" type="IZoneLODGroup" link="IZoneGrouping.html">
        /// The Zone Grouping being registered.
        /// </param>
        /// <returns type="AddressableStreamerBaseUser">A user object deriving from AddressableStreamerBaseUser</returns>
        /// <displayName id="CreateAddressableLoaderUser">
        /// CreateAddressableLoaderUser(IZoneLODGroup)
        /// </displayName>
        /// <syntax>
        /// protected abstract AddressableStreamerBaseUser CreateAddressableLoaderUser(IZoneLODGroup zoneLODGroup)
        /// </syntax>
        protected abstract AddressableStreamerBaseUser CreateAddressableLoaderUser(IZoneLODGroup zoneLODGroup);

        /// <summary>
        /// Instantiates and attaches all cell chunks to the input cells in a single frame. This is not very performant and so should only
        /// be used in Awake or Start, and generally only for testing purposes. Also note that since the AddressableErrorRepairer only works on a 
        /// multi frame basis, it will no the called, and the streamer will automatically try to load the backup assets if any assets fail to load.
        /// <para>
        /// You can override this method in your custom Addressable Chunk Streamer if you do not like the 
        /// default implementation.
        /// </para>
        /// </summary>
        /// <param name="cells" type = "List&lt;WorldCell&gt;" link="WorldCell.html">The cells whose chunks need to be attached.</param>
        /// <param name="userID" type = "int">The ID of the user requesting the attachment.</param>
        /// <displayName id = "LoadAndAttachChunksToCellsInSingleFrame">LoadAndAttachChunksToCellsInSingleFrame(List&lt;WorldCell&gt;, int)</displayName>
        /// <syntax>public override void LoadAndAttachChunksToCellsInSingleFrame(List&lt;WorldCell&gt; cells, int userID)</syntax>
        public override void LoadAndAttachChunksToCellsInSingleFrame(List<WorldCell> cells, int userID)
        {
            var user = (AddressableStreamerBaseUser)RegisteredUsers[userID];
            user.CheckForLoadAndAttachChunksToCellsInSingleFrameExceptions();

            if (user.IsWaitingOnJob)
                user.CompleteAllJobsImmediately();

            foreach (WorldCell cell in cells)
            {
                cell.AllChunkAssetsMatchExpectedLOD = true;
                Cell streamableGridCellToLoad = user.GetStreamableGridCellToLoad(cell);

                for (int chunkIndex = 1; chunkIndex <= cell.NumChunks; chunkIndex++)
                {
                    var chunkCell = new ChunkCell(streamableGridCellToLoad, chunkIndex);
                    bool isCorrectChunkAsset = true;

                    if (user.TryGetReusableAssetLoadInfo(streamableGridCellToLoad, chunkIndex, out int assetKey, out LoadedAsyncOperationInfo loadedInfo))
                    {
                        isCorrectChunkAsset = loadedInfo.isCorrectChunkAsset;

                        //need to increment the instantiation count of the source addressable asset
                        loadedInfo.IncrementUserCount();
                    }
                    else
                    {
                        AsyncOperationHandle loadHandle;
                        string chunkName = null;
                        int attempts = 0;
                        IResourceLocation location = null;
                        string key = null;

AttemptLoad:

                        if (location != null)
                            loadHandle = user.LoadNewAssetAsyncUsingLocation(location, out _);
                        else if (key != null)
                            loadHandle = user.LoadNewAssetAsyncUsingKey(key, out _);
                        else
                            loadHandle = user.LoadNewAssetAsync(streamableGridCellToLoad, chunkIndex, out chunkName, out location, out key, out _);

                        if (loadHandle.WaitForCompletion() != null)
                            goto OnAssetLoaded;
                        else
                        {
                            attempts++;
                            if (attempts == MaxLoadAttempts)
                            {
                                if (user.UseAltLODFailSafe)
                                {
                                    isCorrectChunkAsset = false;
                                    if (PrintErrorToConsole)
                                        Debug.LogError(user.GetPrintError(loadHandle, streamableGridCellToLoad, chunkIndex, AssetType.OriginalAsset, location != null ? location.PrimaryKey : key));

                                    Addressables.Release(loadHandle);
                                    int chunkIndexToLoad = chunkIndex;
                                    int numChunksOnCell = user.LowestQualityLODGridDetails.GetCellChunksUsingStreamableGridCell(streamableGridCellToLoad);
                                    if (chunkIndexToLoad > numChunksOnCell)
                                        chunkIndexToLoad = numChunksOnCell;

                                    loadHandle = user.StreamerOfLowestQualityLODs.LoadAssetForCell(streamableGridCellToLoad, chunkIndexToLoad, user.StreamerUserIDForLowestQualityLODs, out _, out _, out _, out _).Convert<GameObject>();

                                    if (loadHandle.WaitForCompletion() != null)
                                        goto OnAssetLoaded;
                                }

                                if (user.UsePlaceholderFailSafe)
                                {
                                    isCorrectChunkAsset = false;
                                    if (PrintErrorToConsole)
                                        Debug.LogError(user.GetPrintError(loadHandle, streamableGridCellToLoad, chunkIndex, UseAltLODFailSafe ? AssetType.LowestQualityLODAsset : AssetType.OriginalAsset, location != null ? location.PrimaryKey : key));

                                    Addressables.Release(loadHandle);
                                    loadHandle = user.LoadNewAssetAsyncUsingLocation(user.PlaceholderLocation, out _).Convert<GameObject>();

                                    if (loadHandle.WaitForCompletion() != null)
                                        goto OnAssetLoaded;
                                }

                                throw new MissingAssetException($"Could not locate an asset for Chunk {chunkIndex} of Streamable Grid Cell {streamableGridCellToLoad}. If you have 'Use Alt LOD Fail Safe' enabled, please ensure the lowest quality LOD's asset are stored locally on the player device. If you have 'Use Placeholder Fail Safe' enabled, please ensure the place holder addressable asset that should be named {user.ZoneGrouping.GroupName}_PlaceHolder is stored locally on the player device. The key used to try and load this asset was {user.PlaceholderLocation.PrimaryKey}. This asset is associated with the World with ID {user.ZoneGrouping.World.ID} on game object {user.ZoneGrouping.World.gameObject}, Zone {user.ZoneGrouping.ZoneIndex}, World Grouping {user.ZoneGrouping.WorldGroupingIndex} and LOD {user.ZoneGrouping.GridLODDetails.LevelOfDetail}.\n\nHere is the error for the exception reported by Unity for the failed load operation:\n\n{AddressableErrorRepairer.GetDownloadError(loadHandle)}");
                            }
                            else
                            {
                                if (PrintErrorToConsole)
                                    Debug.LogError(user.GetPrintError(loadHandle, streamableGridCellToLoad, chunkIndex, AssetType.OriginalAsset, location != null ? location.PrimaryKey : key));

                                Addressables.Release(loadHandle);
                                goto AttemptLoad;//attempt the load again
                            }
                        }

OnAssetLoaded:

                        loadedInfo = new LoadedAsyncOperationInfo();
                        loadedInfo.handle = loadHandle;
                        loadedInfo.chunkName = chunkName;
                        loadedInfo.isCorrectChunkAsset = isCorrectChunkAsset;
                        loadedInfo.IncrementUserCount();

                        //If the user cannot use reusable assets, the assetKey we have will be 
                        //invalid. We need to get a valid one using GetNonReusableAssetKey
                        if (!user.CanReuseAddressables)
                            assetKey = user.GetNonReusableAssetKey(loadHandle);

                        user.AddLoadedAsyncOpInfo(assetKey, loadedInfo);
                    }

                    ReadyOp readyOp = readyOpPool.WithdrawObject();
                    readyOp.cell = cell;
                    readyOp.chunkIndex = chunkIndex;
                    readyOp.loadedAsyncOpInfo = loadedInfo;

                    var obj = user.SetupChunkFromLoadHandle(readyOp, loadedInfo.handle, out ChunksPositioned chunkPosition);
                    cell.AttachChunkToCell(obj, chunkPosition, chunkIndex);

                    if (!isCorrectChunkAsset)
                        cell.AllChunkAssetsMatchExpectedLOD = false;

                    readyOp.ResetAndReturnToPool(readyOpPool);
                }
            }
        }

        /// <summary>
        /// Loads and attaches the chunks associated with the input cells to the cells over a period of frames.
        /// </summary>
        /// <param name="cells" type = "List&lt;WorldCell&gt;" link="WorldCell.html">The cells whose objects need to be loaded and attached.</param>
        /// <param name="userID" type = "int">The ID of the user requesting the load and attachment.</param>
        /// <displayName id = "LoadAndAttachChunksToCells">LoadAndAttachChunksToCells(List&lt;WorldCell&gt;, int)</displayName>
        /// <syntax>
        /// public sealed override IEnumerator&lt;YieldInstruction&gt; LoadAndAttachChunksToCells(List&lt;WorldCell&gt; cells, int userID)
        /// </syntax>
        /// <returns type = "IEnumerator&lt;YieldInstruction&gt;">
        /// An IEnumerator&lt;YieldInstruction&gt; that can be iterated over or used as a coroutine. See the 
        /// <see href="YieldInstruction.html">YieldInstruction</see> page for more info.
        /// </returns>
        public sealed override IEnumerator<YieldInstruction> LoadAndAttachChunksToCells(List<WorldCell> cells, int userID)
        {
            LoadProgress = 0f;

            return ReusableEnumerators.GetEnumeratorNotInUse<AddressablesLoadAndAttachCellsEnumerator>().PrepareForIteration(this, cells, (AddressableStreamerBaseUser)RegisteredUsers[userID]);
        }


        /// <summary>
        /// Used to load lower quality assets when a streamer is unable to load a higher quality addressable asset. You shouldn't need to 
        /// call this yourself, unless you are creating a custom Addressable Chunk Streamer.
        /// </summary>
        /// <param name="streamableGridCell" type="Cell" link="Cell.html">
        /// The streamable grid cell indexes associated with the asset we want to load.
        /// </param>
        /// <param name="chunkIndex" type="int">
        /// The index of the chunk we want to load.
        /// </param>
        /// <param name="userID" type="int">
        /// The ID of the user whose info will be used to load the asset.
        /// </param>
        /// <param name="chunkName" type="out string">
        /// The name of the chunk asset that this streamer is attempted to load, set once the method executes.
        /// </param>
        /// <param name="location" type="out IResourceLocation">
        /// The IResourceLocation used to load the asset. May be null if the Key was used instead to load the asset.
        /// </param>
        /// <param name="key" type="out string">
        /// The key used to load the asset. May be null if the IResourceLocation was used instead to load the asset.
        /// </param>
        /// <param name="requiresActivation" type="out bool">
        /// Whether the loaded asset handle result requires activation.
        /// </param>
        /// <returns type="AsyncOperationHandle">
        /// An async op handle for the asset that is being loaded.
        /// </returns>
        /// <displayName id="LoadAssetForCell">
        /// LoadAssetForCell(Cell, int, int, out string, out IResourceLocation, out string)
        /// </displayName>
        /// <syntax>
        /// public AsyncOperationHandle LoadAssetForCell(Cell streamableGridCell, int chunkIndex, int userID, out string chunkName, out IResourceLocation location, out string key)
        /// </syntax>
        public AsyncOperationHandle LoadAssetForCell(Cell streamableGridCell, int chunkIndex, int userID, out string chunkName, out IResourceLocation location, out string key, out bool requiresActivation)
        {
            return ((AddressableStreamerBaseUser)RegisteredUsers[userID]).LoadNewAssetAsync(streamableGridCell, chunkIndex, out chunkName, out location, out key, out requiresActivation);
        }


        /// <summary>
        /// Recalculates the IResourceLocations for the addressable assets associated with all users of this streamer. This will do nothing if 
        /// Pre Calculate IResourceLocations is disabled. Only use this when you know the locations need to be recalculated.
        /// <para>
        /// If you only need one users data reculated, use <see cref="RecalculateIResourceLocations(int)" href="AddressableLoaderBase.html#RecalculateIResourceLocations2">RecalculateIResourceLocations</see> instead.
        /// </para>
        /// </summary>
        /// <displayName id="RecalculateIResourceLocations1">
        /// RecalculateIResourceLocations()
        /// </displayName>
        /// <syntax>
        /// public void RecalculateIResourceLocations()
        /// </syntax>
        public void RecalculateIResourceLocations()
        {
            foreach (AddressableStreamerBaseUser user in RegisteredUsers.RegistrantEntries())
                user.CalculateIResourceLocations(this);
        }

        /// <summary>
        /// Recalculates the IResourceLocations for the addressable assets associated with the user ID. This will do nothing if 
        /// Pre Calculate IResourceLocations is disabled. Only use this when you know the locations need to be recalculated.
        /// <para>
        /// You can use the World's <see cref="World.GetChunkStreamerAndID" href="World.html#GetChunkStreamerAndID">GetChunkStreamerAndID</see> 
        /// method in order to find out the chunk streamer ID for a particular World Grouping and LOD.
        /// </para>
        /// </summary>
        /// <param name="userID" type="int">
        /// The ID of the user whose IResourceLocations you want to recalculate.
        /// </param>
        /// <displayName id="RecalculateIResourceLocations2">
        /// RecalculateIResourceLocations(int)
        /// </displayName>
        /// <syntax>
        /// public void RecalculateIResourceLocations(int userID)
        /// </syntax>
        public void RecalculateIResourceLocations(int userID)
        {
            if (!preCalculateIResourceLocations)
                return;

            ((AddressableStreamerBaseUser)RegisteredUsers[userID]).CalculateIResourceLocations(this);
        }

        #endregion

        #region Custom enum/classes

        /// <summary>
        /// Type of addressable asset that is being loaded
        /// </summary>
        protected enum AssetType { OriginalAsset, LowestQualityLODAsset, PlaceholderAsset }

        /// <summary>
        /// Stores information about a successfull async operation
        /// </summary>
        protected class LoadedAsyncOperationInfo
        {
            internal AsyncOperationHandle handle;
            int users = 0;
            internal string chunkName;
            internal bool isCorrectChunkAsset;

            public bool HasUsers { get { return users > 0; } }
            public AsyncOperationHandle Handle { get { return handle; } }
            public string ChunkName { get { return chunkName; } }

            internal LoadedAsyncOperationInfo()
            {
            }

            internal void IncrementUserCount()
            {
                users++;
            }

            internal void DecrementUserCount()
            {
                users--;
            }

            internal void ResetReturnToPool(SelfCreatingPool<LoadedAsyncOperationInfo> pool)
            {
                handle = new AsyncOperationHandle();
                chunkName = null;
                users = 0;
            }
        }

        /// <summary>
        /// Stores information about an Addressable Asset
        /// </summary>
        internal class AddressableAssetInfo
        {
            public IResourceLocation location;
            public string chunkName, chunkLoadKey;
        }

        /// <summary>
        /// Stores information about an async operation that is waiting on a LoadingOp to finish (basically, it 
        /// represents a duplicate request for an asset that is already being loaded).
        /// </summary>
        internal class WaitingOp
        {
            public WorldCell cell;
            public WaitingOp nextInChain;

            public void ResetAndReturnToPool(SelfCreatingPool<WaitingOp> pool)
            {
                cell = null;
                nextInChain = null;

                pool.DepositObject(this);
            }
        }

        /// <summary>
        /// Stores information about a loading operation for an addressable asset. It's possible multiple copies of the 
        /// same asset are requested. In this case, only one LoadingOp is generated and for the copies, WaitingOps are created.
        /// </summary>
        internal class LoadingOp
        {
            public WorldCell worldCell;
            public ChunkCell waitingOpsRetrievalKey;
            public Cell loadedStreamableGridCell;
            public AsyncOperationHandle handle;
            public IResourceLocation location;//may be null;
            public string key, chunkName;//may be null
            public bool isCorrectAssetForChunk, requiresActivation;
            public int chunkIndex;

            public void ResetAndReturnToPool(SelfCreatingPool<LoadingOp> pool)
            {
                handle = new AsyncOperationHandle();
                location = null;
                key = null;
                chunkName = null;
                worldCell = null;
                pool.DepositObject(this);
            }
        }

        /// <summary>
        /// Stores information about a completed op that is ready for processing
        /// </summary>
        protected class ReadyOp
        {
            internal WorldCell cell;
            internal LoadedAsyncOperationInfo loadedAsyncOpInfo;
            internal int chunkIndex;

            public WorldCell Cell { get { return cell; } }
            public LoadedAsyncOperationInfo LoadedAsyncOpInfo { get { return loadedAsyncOpInfo; } }
            public int ChunkIndex { get { return chunkIndex; } }
            internal void ResetAndReturnToPool(SelfCreatingPool<ReadyOp> pool)
            {
                cell = null;
                loadedAsyncOpInfo = null;
                pool.DepositObject(this);
            }
        }

        #endregion

        #region AddressableStreamerBaseUser
        /// <summary>
        /// Base User class for addressable chunk streamers
        /// </summary>
        protected abstract class AddressableStreamerBaseUser : ChunkStreamerUser
        {
            #region Fields
            static Func<AddressableStreamerBaseUser, Cell, int, CellString> MatchThenReturnCellString, DoNotMatchThenReturnCellString;

            AddressableBaseChunkStreamer parent;
            Cell cellWithChunkSetToUse;
            EqualityComparer<ChunkCell> comparer;
            CellString[] perChunkCellStrings;//only used with Single Object Mode

            JobHandle findLargesChunkJobHandle;
            NativeArray<int> largestChunkResult;
            #endregion

            #region Properties

            //Private

            /// <summary>
            /// When Pre Calculate IResource Locations is enabled, this contains the IResourceLocation and chunkName for every chunk of every 
            /// cell associated with this user. Use CalculateIndex with a StreamableGridIndex to get the index for the first array, then use the 
            /// 0 based chunk index for the second array index.
            /// </summary>
            AddressableAssetInfo[][] ChunkInfo { get; set; }
            /// <summary>
            /// Translates a StreamableGridIndex to an index in a 1D array. For example, Streamable Grid 1_1 is translated to index 0, 1_2 is translated 
            /// to 1, and so on. Automatically accounts for whether the user is using a 2D or 3D Streamable Grid.
            /// </summary>
            Func<Cell, int> CalculateChunkInfoIndex { get; set; }
            Func<WorldCell, Cell> GetWaitingOpsKeyCell { get; set; }
            Func<AddressableStreamerBaseUser, Cell, int, CellString> MatchOrDontThenGetCellString { get; set; }
            Dictionary<int, LoadedAsyncOperationInfo> LoadedAsyncOperations { get; set; }
            bool IsFindLargestChunkJobRunning { get { return largestChunkResult.IsCreated; } }

            /// <summary>
            /// Whether the addressable assets (associated with the load operation) loaded by your streamer 
            /// implementation can be reused between cells with the same Streamable Grid Cell index. For example, the 
            /// default Addressable Scene Streamer returns false for this, because scenes do not use an underlying 
            /// asset that can be reused. The Prefab Streamer, on the other hand, returns true, because there is an 
            /// underlying prefab asset that is loaded, which can be instantiated as many times as needed in order 
            /// to be shared among different World Cells with the same Streamable Grid Cell index.
            /// <para>
            /// Reusing the underlying addressable asset is beneficial because it cuts down on the number of 
            /// Async load operations needed. When this returns true, the key used to store each LoadedAsyncOperationInfo object is a combination of the 
            /// Streamable Grid Cell index of the World Cell that triggered the load, and the chunk index of whatever chunk is needed by the cell. 
            /// When other World Cells using the same Streamable Grid Cell index 
            /// need to have chunks loaded for them, they are able to use the index (plus chunk number of the asset they need) 
            /// to identify an addressable asset that has already 
            /// been loaded, and use it to make a copy that can be used for that World Cell.
            /// </para>
            /// <para>
            /// When this returns false, each World Cell will trigger an Async Load Operation, even if a World Cell with the same 
            /// Streamable Grid Cell indexes has already been loaded. The key used to store the LoadedAsyncOperationInfo comes from the 
            /// AsyncOperationHandle itself, which is retrieved by calling the GetNonReusableAssetKey method (which you also need 
            /// to implement in your custom user class).
            /// </para>
            /// </summary>
            public abstract bool CanReuseAddressables { get; }

            /// <summary>
            /// A function that can be used to retrieve a reusable asset key
            /// </summary>
            public Func<Cell, int, int> GetReusableAssetKey { get; set; }

            /// <summary>
            /// The Max Async Unload Ops To Start In A Single Frame. If the LOD Group has Extra Data available corresponding to this, that data will have been 
            /// used to set this value. If not, this will be set to Default Max Async Unload Ops To Start In Single Frame
            /// </summary>
            public int MaxAsyncHandlesToReleaseInSingleFrame { get; private set; }

            /// <summary>
            /// The Max Chunks To Configure In A Single Frame. If the LOD Group has Extra Data available corresponding to this, that data will have been 
            /// used to set this value. If not, this will be set to Default Max Chunks To Configure In Single Frame
            /// </summary>
            public int MaxChunksToConfigureInSingleFrame { get; private set; }

            /// <summary>
            /// Gets the max async loads that can be run at the same time. Return 0 to tell base chunk streamer that there is no max amount.
            /// </summary>
            protected abstract int MaxConcurrentAsyncLoads { get; }

            /// <summary>
            /// The file type of the addressable assets (for example typeof(SceneInstance) or typeof(GameObject))
            /// </summary>
            protected abstract Type FileType { get; }

            /// <summary>
            /// Gets a value indicating whether the user is waiting on a multi threaded job to finish. This is very unlikely to ever be true, however it is still necessary 
            /// to check this in your custom streamer whenever one of its public methods is called (such as 
            /// LoadAndAttachChunksToCellsInSingleFrame or DetatchAndUnloadChunksFromCells). If the method is an enumerator, simply yield 
            /// until IsWaitingOnJob returns false. If there is no possibility to wait (i.e., the method returns something other than IEnumerator&lt;YieldInstruction&gt;) 
            /// you can call the method CompleteAllJobsImmediately to force the any running jobs to complete immediately.
            /// </summary>
            public bool IsWaitingOnJob { get; private set; }

            /// <summary>
            /// When UseAltLODFailSafe is true, this returns the GridLODDetails object associated with the lowest quality LOD on the same Streamable Grid 
            /// that this user is using.
            /// </summary>
            internal GridLODDetails LowestQualityLODGridDetails { get; private set; }

            /// <summary>
            /// When UsePlaceholderFailSafe is true, this returns the IResourceLocation of the Placeholder asset.
            /// </summary>
            internal IResourceLocation PlaceholderLocation { get; private set; } = null;

            /// <summary>
            /// When UseAltLODFailSafe returns true, this returns the chunk streamer to use to load Alt LOD 
            /// Fail-Safe assets when an asset download fails.
            /// </summary>
            internal AddressableBaseChunkStreamer StreamerOfLowestQualityLODs { get; private set; }

            internal int ComparisonReadyMaxConcurrentAsyncLoads { get; private set; }

            internal int StreamerUserIDForLowestQualityLODs { get; private set; }

            /// <summary>
            /// Whether to use the Alt LOD Fail Safe when an asset download fails.
            /// </summary>
            internal bool UseAltLODFailSafe { get; private set; }

            /// <summary>
            /// Whether to use the Placeholder Fail Safe when an asset download fails.
            /// </summary>
            internal bool UsePlaceholderFailSafe { get { return PlaceholderLocation != null; } }
            internal Func<WorldCell, Cell> GetStreamableGridCellToLoad { get; private set; }
            AddressablesLoadAndAttachCellsEnumerator EnumeratorDriver { get; set; }

            #endregion

            #region Private Constructor Methods
            public AddressableStreamerBaseUser(AddressableBaseChunkStreamer parent, IZoneLODGroup zoneLODGroup) : base(parent, zoneLODGroup)
            {
                this.parent = parent;

                if (MatchThenReturnCellString == null)
                {
                    MatchThenReturnCellString = (user, cellOnStreamableGrid, chunkIndex) =>
                    {
                        var cellString = user.CellString;
                        cellString.MatchStringToCell(cellOnStreamableGrid, chunkIndex);
                        return cellString;
                    };
                }

                if (DoNotMatchThenReturnCellString == null)
                {
                    DoNotMatchThenReturnCellString = (user, cellOnStreamableGrid, chunkIndex) =>
                    {
                        return user.GetChunkCellString(chunkIndex - 1);//the chunk cell strings are already matched to the single object, so don't match
                    };
                }

                int roughCapcityOfLoadedAsyncOpDictionary;
                if (ZoneGrouping.GridLODDetails.UseSingleChunkSetForAllCells_PreInitSafe)
                {
                    cellWithChunkSetToUse = ZoneGrouping.GridLODDetails.StreamableGridCellWithChunkSetToUse_PreInitSafe;
                    GetStreamableGridCellToLoad = (cell) => cellWithChunkSetToUse;

                    MatchOrDontThenGetCellString = DoNotMatchThenReturnCellString;
                }
                else
                {
                    GetStreamableGridCellToLoad = (cell) => cell.CellOnStreamableGrid;
                    MatchOrDontThenGetCellString = MatchThenReturnCellString;
                }

                if (CanReuseAddressables)
                {
                    GetWaitingOpsKeyCell = GetStreamableGridCellToLoad;

                    if (ZoneGrouping.GridLODDetails.UseSingleChunkSetForAllCells_PreInitSafe)
                    {
                        roughCapcityOfLoadedAsyncOpDictionary = perChunkCellStrings.Length;//this lengths equates to to the number

                        //there will only ever be as many items in the dictionary as there are chunks on the single Streamable Grid cell being 
                        //used for the single cell object set
                        GetReusableAssetKey = (streamableGridCellIndex, chunkIndex) => chunkIndex - 1;
                    }
                    else
                    {
                        roughCapcityOfLoadedAsyncOpDictionary = 25;

                        //in order to construct the GetReusableAssetKey function when using the full set of Streamable Grid cells, we need to 
                        //investigate the chunk layout 
                        //we need to use FlattenEnabledCellIndex for the GetReusableAssetKey function because when dealing with multi chunk Streamable Grids
                        //each cell has x number of "slots" available to it. If we were to use FlattenCellIndex, the number of slots would be 
                        //incredibly large for big worlds and many of those slots would never be used. Using FlattenEnabledCellIndex ensures we only have 
                        //slots for enabled cells, therefore they will be used
                        if (!ZoneGrouping.GridLODDetails.UtilizesMultiChunking_PreInitSafe)
                            GetReusableAssetKey = (streamableGridCellIndex, chunkIndex) => ZoneGrouping.GridLODDetails.StreamableGrid.FlattenCellIndexForSparseEnabledArray(streamableGridCellIndex);
                        else if (ZoneGrouping.GridLODDetails.DoAllCellsUseSameNumberOfChunks)
                        {
                            int chunksUsedByAllCells = ZoneGrouping.GridLODDetails.GetCellChunksUsingStreamableGridCell(Cell.One);
                            if (chunksUsedByAllCells == 1)
                                GetReusableAssetKey = (streamableGridCellIndex, chunkIndex) => ZoneGrouping.GridLODDetails.StreamableGrid.FlattenCellIndexForSparseEnabledArray(streamableGridCellIndex);
                            else//here we allocate x indexes for each cell, where x = number of chunks used. Chunk 1 is always at index 0 of the allocation space for each cell
                                GetReusableAssetKey = (streamableGridCellIndex, chunkIndex) => ZoneGrouping.GridLODDetails.StreamableGrid.FlattenCellIndexForSparseEnabledArray(streamableGridCellIndex) * chunksUsedByAllCells + chunkIndex - 1;
                        }
                        else
                        {
                            var lodDetails = ZoneGrouping.GridLODDetails;
                            long numCells = lodDetails.StreamableGrid.EnabledCells;
                            if (numCells < 1000)
                            {
                                int maxChunkValue = 0;
                                foreach (var cell in lodDetails.StreamableGrid.EnabledStreamableGridCells())
                                {
                                    var chunksUsedByCell = lodDetails.GetCellChunksUsingStreamableGridCell(cell);
                                    if (chunksUsedByCell > maxChunkValue)
                                        maxChunkValue = chunksUsedByCell;
                                }

                                GetReusableAssetKey = (streamableGridCellIndex, chunkIndex) => ZoneGrouping.GridLODDetails.StreamableGrid.FlattenCellIndexForSparseEnabledArray(streamableGridCellIndex) * maxChunkValue + chunkIndex - 1;
                            }
                            else
                            {
                                parent.StartCoroutine(FindLargestChunkValueUsingJob(lodDetails));
                            }
                        }
                    }
                }
                else
                {
                    GetWaitingOpsKeyCell = (cell) => cell.CellOnEndlessGrid;

                    roughCapcityOfLoadedAsyncOpDictionary = 25;
                }

                if (parent.preCalculateIResourceLocations)
                    CalculateIResourceLocations(parent);

                if (parent.usePlaceholderFailSafe)
                    CalculatePlaceHolderLocation(parent);
                else
                    PlaceholderLocation = null;

                ConfigureAltLODFailSafe();

                CreateObjects(roughCapcityOfLoadedAsyncOpDictionary);
                SetMaxProperties();
            }

            void CreateChunkInfoArray(int arraySize)
            {
                ChunkInfo = new AddressableAssetInfo[arraySize][];

                if (ZoneGrouping.GridLODDetails.UseSingleChunkSetForAllCells_PreInitSafe)
                {
                    int numChunks = ZoneGrouping.GridLODDetails.GetCellChunksUsingStreamableGridCell(cellWithChunkSetToUse);
                    ChunkInfo[0] = new AddressableAssetInfo[numChunks];
                    for (int c = 0; c < ChunkInfo[0].Length; c++)
                    {
                        var chunkInfoObj = new AddressableAssetInfo();
                        var cellString = GetChunkCellString(c);//
                        chunkInfoObj.chunkName = cellString.ChunkName;
                        chunkInfoObj.chunkLoadKey = cellString.ChunkLoadKey;
                        ChunkInfo[0][c] = chunkInfoObj;
                    }
                }
                else
                {
                    int i = 0;
                    foreach (var cell in ZoneGrouping.GridLODDetails.StreamableGrid.EnabledStreamableGridCells())
                    {
                        int numChunks = ZoneGrouping.GridLODDetails.GetCellChunksUsingStreamableGridCell(cell);
                        ChunkInfo[i] = new AddressableAssetInfo[numChunks];
                        for (int c = 0; c < ChunkInfo[i].Length; c++)
                        {
                            var chunkInfoObj = new AddressableAssetInfo();
                            CellString.MatchStringToCell(cell, c + 1);
                            chunkInfoObj.chunkName = CellString.ChunkName;
                            chunkInfoObj.chunkLoadKey = CellString.ChunkLoadKey;
                            ChunkInfo[i][c] = chunkInfoObj;
                        }

                        i++;
                    }
                }
            }

            void CalculatePlaceHolderLocation(AddressableBaseChunkStreamer parent)
            {
                var cellString = CellString != null ? CellString : GetChunkCellString(0);

                if (parent.reusableStringList == null)
                    parent.reusableStringList = new List<string>(1);

                parent.reusableStringList.Add($"{cellString.PrependLoadStringData}{ZoneGrouping.GroupName}_Placeholder{cellString.AppendLoadStringData}");
                var result = Addressables.LoadResourceLocationsAsync(parent.reusableStringList, Addressables.MergeMode.None, FileType);
                parent.reusableStringList.Clear();
                if (result.Status == AsyncOperationStatus.Succeeded && result.Result.Count > 0)
                    PlaceholderLocation = result.Result[0];
            }

            void ConfigureAltLODFailSafe()
            {
                if (!parent.useAltLODFailSafe)
                    UseAltLODFailSafe = false;
                else
                {
                    //we need to make sure it's actually possible to use a lowest quality LOD
                    //if the Streamable Grid only has a single LOD, or if this users LOD already the lowest quality LOD, then it is not possible
                    if (ZoneGrouping.GridLODDetails.StreamableGrid.LevelsOfDetail_PreInitSafe > 1 && ZoneGrouping.GridLODDetails.LevelOfDetail != ZoneGrouping.GridLODDetails.StreamableGrid.LevelsOfDetail_PreInitSafe)
                    {
                        ChunkStreamer streamer;
                        int loaderID;
                        ZoneGrouping.World.GetChunkStreamerAndID(ZoneGrouping.ZoneIndex, ZoneGrouping.WorldGroupingIndex, ZoneGrouping.GridLODDetails.StreamableGrid.LevelsOfDetail_PreInitSafe, out streamer, out loaderID);
                        UseAltLODFailSafe = IsLowestQualityLODStreamerCompatible(streamer);
                        if (UseAltLODFailSafe)
                        {
                            StreamerOfLowestQualityLODs = (AddressableBaseChunkStreamer)streamer;
                            StreamerUserIDForLowestQualityLODs = loaderID;
                            LowestQualityLODGridDetails = ZoneGrouping.GridLODDetails.StreamableGrid.GetLODDetails_PreInitSafe(ZoneGrouping.GridLODDetails.StreamableGrid.LevelsOfDetail_PreInitSafe);
                        }
                    }
                    else
                        UseAltLODFailSafe = false;
                }
            }

            void CreateObjects(int roughCapacityOfLoadedOpDictionary)
            {
                var wg = ZoneGrouping.GridLODDetails.StreamableGrid;

                if (wg.IsGrid3D)
                    comparer = new ThreeDimensionalChunkCellComparer();
                else
                    comparer = new TwoDimensionalChunkCellComparer();

                LoadedAsyncOperations = new Dictionary<int, LoadedAsyncOperationInfo>(roughCapacityOfLoadedOpDictionary);

            }

            void SetMaxProperties()
            {
                SetMaxChunksToConfigureInSingleFrame();
                SetMaxAsyncHandlesToReleaseInSingleFrame();
            }
            internal void SetMaxChunksToConfigureInSingleFrame()
            {
                int newValue;
                if (parent.maxChunksToConfigureKey != null && parent.maxChunksToConfigureKey.Length > 0 && ZoneGrouping.GridLODDetails.TryGetExtraData_PreInitSafe(parent.maxChunksToConfigureKey, out string parseData))
                {
                    newValue = int.Parse(parseData);
                }
                else
                    newValue = parent.defaultMaxChunksToConfigureInSingleFrame;

                //this way we don't have to check if the value is 0, instead this value will always be larger than whatever we are comparing against it.
                if (newValue <= 0)
                    newValue = int.MaxValue;

                if (newValue != MaxChunksToConfigureInSingleFrame)
                {
                    MaxChunksToConfigureInSingleFrame = newValue;
                    OnMaxChunksToConfigureInSingleFrameChanged();
                }
            }
            protected virtual void OnMaxChunksToConfigureInSingleFrameChanged() { }
            internal void SetMaxAsyncHandlesToReleaseInSingleFrame()
            {
                int newValue;
                if (parent.maxAsyncHandlesReleaseKey != null && parent.maxAsyncHandlesReleaseKey.Length > 0 && ZoneGrouping.GridLODDetails.TryGetExtraData_PreInitSafe(parent.maxAsyncHandlesReleaseKey, out string parseData))
                {
                    newValue = int.Parse(parseData);
                }
                else
                    newValue = parent.defaultMaxAsyncHandlesToReleaseInSingleFrame;

                //this way we don't have to check if the value is 0, instead this value will always be larger than whatever we are comparing against it.
                if (newValue <= 0)//- values will cause issues, so treat them as 0
                    newValue = int.MaxValue;

                if (newValue != MaxAsyncHandlesToReleaseInSingleFrame)
                {
                    MaxAsyncHandlesToReleaseInSingleFrame = newValue;
                    OnMaxAsyncHandlesToReleaseInSingleFrameChanged();
                }
            }
            protected virtual void OnMaxAsyncHandlesToReleaseInSingleFrameChanged() { }

            /// <summary>
            /// If creating a custom chunk streamer deriving from this class, you must call this whenever the value returned by 
            /// MaxConcurrentAsyncLoads changes.
            /// </summary>
            protected void OnMaxConcurrentAsyncLoadsChanged()
            {
                ComparisonReadyMaxConcurrentAsyncLoads = MaxConcurrentAsyncLoads;
                if (ComparisonReadyMaxConcurrentAsyncLoads == 0)
                    ComparisonReadyMaxConcurrentAsyncLoads = int.MaxValue;
            }
            #endregion

            #region Other Private Methods

            AsyncOperationHandle LoadNewAssetAsyncUsingKey(Cell cellOnStreamableGrid, int chunkIndex, out string chunkName, out string key, out bool requiresActivation)
            {
                var cellString = MatchOrDontThenGetCellString(this, cellOnStreamableGrid, chunkIndex);
                chunkName = cellString.ChunkName;
                key = cellString.ChunkLoadKey;
                return LoadNewAssetAsyncUsingKey(key, out requiresActivation);
            }

            CellString GetChunkCellString(int chunkIndex_ZeroBased)
            {
                return perChunkCellStrings[chunkIndex_ZeroBased];
            }

            IEnumerator<YieldInstruction> FindLargestChunkValueUsingJob(GridLODDetails lodDetails)
            {
                IsWaitingOnJob = true;
                var chunkValues = lodDetails.GetChunksArrayAsNativeArray(Allocator.TempJob);
                largestChunkResult = new NativeArray<int>(1, Allocator.TempJob, NativeArrayOptions.UninitializedMemory);
                findLargesChunkJobHandle = new FindLargestValue() { values = chunkValues, largestValue = largestChunkResult }.Schedule();
                JobHandle.ScheduleBatchedJobs();

                while (IsFindLargestChunkJobRunning && !findLargesChunkJobHandle.IsCompleted)
                    yield return null;

                //possible the job was complpeted immediately, in which case it will not be running
                if (!IsFindLargestChunkJobRunning)
                    yield break;

                OnFindLargestChunkValueJobCompleted();
            }

            void OnFindLargestChunkValueJobCompleted()
            {
                findLargesChunkJobHandle.Complete();
                int maxChunkValue = largestChunkResult[0];
                largestChunkResult.Dispose();

                GetReusableAssetKey = (streamableGridCellIndex, chunkIndex) => ZoneGrouping.GridLODDetails.StreamableGrid.FlattenCellIndexForSparseEnabledArray(streamableGridCellIndex) * maxChunkValue + chunkIndex - 1;

                //if we add more jobs, check to make sure those aren't running
                findLargesChunkJobHandle = default;
                IsWaitingOnJob = false;
            }

            struct FindLargestValue : IJob
            {
                [ReadOnly, DeallocateOnJobCompletion] public NativeArray<int> values;

                public NativeArray<int> largestValue;

                public void Execute()
                {
                    int l = values[0];
                    for (int i = 1; i < values.Length; i++)
                    {
                        if (values[i] > l)
                            l = values[i];
                    }
                    largestValue[0] = l;
                }
            }
            #endregion

            #region Protected Methods

            /// <summary>
            /// Determines if the Chunk Streamer used by the lowest quality LOD for the Streamable Grid associated with this user 
            /// is compatible with the type of Addressable Chunk Streamer in use. Typically it should be of the same type. This is only 
            /// called when UseAltLODFailSafe would otherwise be true. If you return false from this method, UseAltLODFailSafe will be made false as well. 
            /// <para>
            /// If the streamer is compatible, you can and should store it (casted to the derived type of streamer you 
            /// are using) along with the chunkStreamerUserID to avoid having to look up the streamer and ID each time they are needed.
            /// </para>
            /// </summary>
            /// <param name="streamerOfLowestQualityLODAssets">The Chunk Streamer used by the lowest quality LOD.</param>
            /// <returns>Whether the streamer is compatible.</returns>
            protected abstract bool IsLowestQualityLODStreamerCompatible(ChunkStreamer streamerOfLowestQualityLODAssets);

            protected sealed override CellString CreateCellString(IZoneLODGroup zoneLODGroup, string extraDataToPrepend, string extraDataToAppend)
            {
                if (!ZoneGrouping.GridLODDetails.UseSingleChunkSetForAllCells_PreInitSafe)
                {
                    return new CellString(ZoneGrouping.GroupName, ZoneGrouping.GridLODDetails.NamingConvention, ZoneGrouping.GridLODDetails.StreamableGrid.IsGrid3D, ZoneGrouping.GridLODDetails.UtilizesMultiChunking_PreInitSafe, extraDataToPrepend, extraDataToAppend);
                }
                else
                {
                    Cell singleChunkSetStreamableGridCell = ZoneGrouping.GridLODDetails.StreamableGridCellWithChunkSetToUse_PreInitSafe;

                    int numChunks = ZoneGrouping.GridLODDetails.GetCellChunksUsingStreamableGridCell(singleChunkSetStreamableGridCell);

                    perChunkCellStrings = new CellString[numChunks];
                    for (int i = 0; i < numChunks; i++)
                    {
                        perChunkCellStrings[i] = new CellString(ZoneGrouping.GroupName, ZoneGrouping.GridLODDetails.NamingConvention, ZoneGrouping.GridLODDetails.StreamableGrid.IsGrid3D, ZoneGrouping.GridLODDetails.UtilizesMultiChunking_PreInitSafe, extraDataToPrepend, extraDataToAppend);
                        perChunkCellStrings[i].MatchStringToCell(singleChunkSetStreamableGridCell, i + 1);
                    }

                    return null;//we are not going to use the base user's Cell String field, so just set it to null
                }
            }
            #endregion

            #region Internal Methods
            /// <summary>
            /// Can be used to recalculate the IResourceLocations of each cell and its chunks. Should only be used if you expect the 
            /// locations to be changed, for instance if you change the IResourceLocator.
            /// </summary>
            /// <param name="parent"></param>
            internal void CalculateIResourceLocations(AddressableBaseChunkStreamer parent)
            {
                int chunkInfoArraySize;
                if (ZoneGrouping.GridLODDetails.UseSingleChunkSetForAllCells_PreInitSafe)
                {
                    if (CalculateChunkInfoIndex == null)
                        CalculateChunkInfoIndex = (cell) => 0;

                    chunkInfoArraySize = 1;
                }
                else
                {
                    chunkInfoArraySize = (int)ZoneGrouping.GridLODDetails.StreamableGrid.EnabledCells;
                    if (CalculateChunkInfoIndex == null)
                        CalculateChunkInfoIndex = (cell) => ZoneGrouping.GridLODDetails.StreamableGrid.FlattenCellIndexForSparseEnabledArray(cell);
                }

                if (ChunkInfo == null)
                    CreateChunkInfoArray(chunkInfoArraySize);

                if (parent.reusableStringList == null)
                    parent.reusableStringList = new List<string>(chunkInfoArraySize);
                else if (parent.reusableStringList.Count > 0)
                    parent.reusableStringList.Clear();

                for (int i = 0; i < ChunkInfo.Length; i++)
                {
                    var chunks = ChunkInfo[i];
                    for (int c = 0; c < chunks.Length; c++)
                        parent.reusableStringList.Add(chunks[c].chunkLoadKey);
                }

                var handle = Addressables.LoadResourceLocationsAsync(parent.reusableStringList, Addressables.MergeMode.Union, FileType);
                var results = handle.WaitForCompletion();

                if (results == null)
                {
                    Debug.LogWarning($"The Resource Locations for Zone {ZoneGrouping.ZoneIndex}, World Grouping {ZoneGrouping.WorldGroupingIndex}, LOD Group {ZoneGrouping.GridLODDetails.LevelOfDetail} on the World with ID {ZoneGrouping.World.ID} on Game Object {ZoneGrouping.World.gameObject.name} could not be pre calculated using the provided keys (example of key: {parent.reusableStringList[0]}). The streamer will attempt to use the chunk names as keys, however there is a good chance this will not work either and that your addressables will not be able to be loaded.");
                }
                else if (results.Count != parent.reusableStringList.Count)
                {
                    Debug.LogWarning($"Only {results.Count} out of {parent.reusableStringList.Count} Resource Locations could be calculated for Zone {ZoneGrouping.ZoneIndex}, World Grouping {ZoneGrouping.WorldGroupingIndex}, LOD Group {ZoneGrouping.GridLODDetails.LevelOfDetail} on the World with ID {ZoneGrouping.World.ID} on Game Object {ZoneGrouping.World.gameObject.name}. This typically happens if one or more assets are missing. If you expected the assets from this LOD Group/World Grouping to be missing, you can ignore this warning, however if you did not, please check to make sure your Streamable Grid is setup correctly and that all Enabled Grid Cells have a corresponding Asset Chunk (or more than one Asset Chunks if that cell is using multiple chunks).");
                }
                else
                {
                    for (int i = 0, r = 0; i < ChunkInfo.Length; i++)
                    {
                        var chunks = ChunkInfo[i];
                        for (int c = 0; c < chunks.Length; c++, r++)
                        {
                            chunks[c].location = results[r];
                        }
                    }
                }

                Addressables.Release(handle);

                parent.reusableStringList.Clear();
            }
            internal string GetPrintError(LoadingOp op, AssetType assetType, string key)
            {
                return GetPrintError(op.handle, op.loadedStreamableGridCell, op.chunkIndex, assetType, key);
            }
            internal string GetPrintError(AsyncOperationHandle handle, Cell streamableGridCell, int chunkIndex, AssetType assetType, string key)
            {
                return $"A failure to load the {assetType} has occured for Chunk {chunkIndex} of the World Cell with Streamable Grid Indexes {streamableGridCell}. If the asset was an original asset then it was the original asset associated with the cell chunk, and may have failed due to connection issues.\n\nIf the asset was a low quality LOD fail-safe asset, please ensure the lowest quality LOD's asset are stored locally on the player device.\n\nIf the asset was a placeholder asset, please ensure the place holder addressable asset that should be named {ZoneGrouping.GroupName}_PlaceHolder is stored locally on the player device.\n\nAdditional Information:\nThe key used to try and load this asset was {key}.\n\nThis asset is associated with the World with ID {ZoneGrouping.World.ID} on game object {ZoneGrouping.World.gameObject}, Zone {ZoneGrouping.ZoneIndex}, World Grouping {ZoneGrouping.WorldGroupingIndex} and LOD {ZoneGrouping.GridLODDetails.LevelOfDetail}.\n\nHere is the error for the exception reported by Unity for the failed load operation:\n\n{AddressableErrorRepairer.GetDownloadError(handle)}\n\nYou can ignore this message if it was expected.";
            }
            internal void LoadGameObjectAsyncIfNeeded(WorldCell cell, int chunkIndex, out bool newAsyncOpStarted)
            {
                newAsyncOpStarted = false;
                ChunkCell waitingOpsKey;
                Cell streamableGridCellToLoad = GetStreamableGridCellToLoad(cell);

                if (CanReuseAddressables)
                {
                    int assetKey = GetReusableAssetKey(streamableGridCellToLoad, chunkIndex);
                    if (LoadedAsyncOperations.TryGetValue(assetKey, out LoadedAsyncOperationInfo opInfo))
                    {
                        parent.conditionalMembers.OnAssetChunkLoaded(cell, chunkIndex);
                        var readyOp = readyOpPool.WithdrawObject();
                        readyOp.cell = cell;
                        readyOp.chunkIndex = chunkIndex;
                        readyOp.loadedAsyncOpInfo = opInfo;
                        EnumeratorDriver.ReadyOps.Add(readyOp);
                        return;
                    }

                    waitingOpsKey = new ChunkCell(GetWaitingOpsKeyCell(cell), chunkIndex);

                    //in this case the asset must currently be loading
                    if (EnumeratorDriver.WaitingOps.TryGetValue(waitingOpsKey, out WaitingOp firstWaitingOpInChain))
                    {
                        var newWaitingOp = waitingOpPool.WithdrawObject();
                        newWaitingOp.cell = cell;

                        var lastInChain = firstWaitingOpInChain;
                        while (lastInChain.nextInChain != null)
                            lastInChain = lastInChain.nextInChain;

                        lastInChain.nextInChain = newWaitingOp;
                        return;
                    }
                }
                else
                    waitingOpsKey = new ChunkCell(GetWaitingOpsKeyCell(cell), chunkIndex);

                //if it gets here, it means there is no addressable already loading or in the process of loading
                //chunkName is gauranteed to be not null
                //one of location or key will be null, the other not. Favor using location if not null
                parent.conditionalMembers.OnInitiatingAssetChunkLoad(cell, chunkIndex);
                AsyncOperationHandle loadHandle = LoadNewAssetAsync(streamableGridCellToLoad, chunkIndex, out string chunkName, out IResourceLocation location, out string key, out bool requiresActivation);
                parent.conditionalMembers.OnAssetChunkLoadInitiated(cell, chunkIndex);

                newAsyncOpStarted = true;
                var loadOp = loadingOpPool.WithdrawObject();
                loadOp.worldCell = cell;
                loadOp.requiresActivation = requiresActivation;
                loadOp.waitingOpsRetrievalKey = waitingOpsKey;
                loadOp.loadedStreamableGridCell = streamableGridCellToLoad;
                loadOp.handle = loadHandle;
                loadOp.location = location;
                loadOp.key = key;
                loadOp.isCorrectAssetForChunk = true;
                loadOp.chunkIndex = chunkIndex;
                loadOp.chunkName = chunkName;

                loadOp.handle.Completed += EnumeratorDriver.OnAssetLoaded;

                EnumeratorDriver.LoadingOps.Add(loadOp);

                var waitingOp = waitingOpPool.WithdrawObject();
                waitingOp.cell = cell;

                EnumeratorDriver.WaitingOps.Add(waitingOpsKey, waitingOp);
            }
            internal AsyncOperationHandle LoadNewAssetAsync(Cell cellOnStreamableGrid, int chunkIndex, out string chunkName, out IResourceLocation location, out string key, out bool requiresActivation)
            {
                location = null;
                key = null;

                if (ChunkInfo == null)
                {
                    return LoadNewAssetAsyncUsingKey(cellOnStreamableGrid, chunkIndex, out chunkName, out key, out requiresActivation);
                }

                var cellLoadInfo = ChunkInfo[CalculateChunkInfoIndex(cellOnStreamableGrid)];
                if (cellLoadInfo == null)
                {
                    return LoadNewAssetAsyncUsingKey(cellOnStreamableGrid, chunkIndex, out chunkName, out key, out requiresActivation);
                }

                var chunkLoadInfo = cellLoadInfo[chunkIndex - 1];
                if (chunkLoadInfo == null)
                {
                    return LoadNewAssetAsyncUsingKey(cellOnStreamableGrid, chunkIndex, out chunkName, out key, out requiresActivation);
                }
                else if (chunkLoadInfo.location == null)
                {
                    chunkName = chunkLoadInfo.chunkName;
                    key = chunkLoadInfo.chunkLoadKey;
                    return LoadNewAssetAsyncUsingKey(key, out requiresActivation);
                }

                chunkName = chunkLoadInfo.chunkName;
                location = chunkLoadInfo.location;
                return LoadNewAssetAsyncUsingLocation(location, out requiresActivation);
            }
            internal void SetEnumeratorDriver(YieldEnumeratorWithParent_RefOnly<AddressableBaseChunkStreamer, List<WorldCell>, AddressableStreamerBaseUser> driver)
            {
                EnumeratorDriver = driver as AddressablesLoadAndAttachCellsEnumerator;
            }
            #endregion

            #region Public Methods
            //note that we pass in the true Streamable Grid Cell of the World Cell. We have set up our cell strings retrieval methods and chunk info index calculator 
            //to factor in whether the user is using a single cell object strategy


            /// <summary>
            /// Use to try and retrieve LoadedAsyncOperationInfo for a reusable asset that has already 
            /// been loaded.  If your custom addressable chunk streamer has asset reuse disabled, 
            /// will always return false and you must ignore the out arguments.
            /// </summary>
            /// <param name="worldCell">
            /// The world cell whose chunks you are trying to load.
            /// </param>
            /// <param name="chunkIndex">
            /// The index of the chunk you are trying to load.
            /// </param>
            /// <param name="streamableGridCellToLoad">
            /// The Streamable Grid Cell that will actually be loaded for this World Cell, as calculated 
            /// by the user based on whether the zoneGrouping is using a Single Object Cell Set
            /// </param>
            /// <param name="assetKey">
            /// The key produced by the user to try and retrieve the asset load info. Will be set 
            /// correctly so long as the custom addressable chunk streamer does not have asset reuse disabled.
            /// </param>
            /// <param name="info">
            /// If the method returns true, this will contain the info about the async operation handle that 
            /// was used to load the asset to be reused (found in the handles .Result property). Note, if you 
            /// use the Result, you must call IncrementUserCount!
            /// </param>
            /// <returns>
            /// Returns true if there is an addressable asset that can be reused by the input World Cell, 
            /// and false if not.
            /// </returns>
            public bool TryGetReusableAssetLoadInfo(WorldCell worldCell, int chunkIndex, out Cell streamableGridCellToLoad, out int assetKey, out LoadedAsyncOperationInfo info)
            {
                if (!CanReuseAddressables)
                {
                    streamableGridCellToLoad = Cell.Zero;
                    assetKey = -1;
                    info = null;
                    return false;
                }
                streamableGridCellToLoad = GetStreamableGridCellToLoad(worldCell);
                assetKey = GetReusableAssetKey(streamableGridCellToLoad, chunkIndex);
                return TryGetAssetLoadInfo(assetKey, out info);
            }

            /// <summary>
            /// Use to try and retrieve LoadedAsyncOperationInfo for a reusable asset that has already 
            /// been loaded. If your custom addressable chunk streamer has asset reuse disabled, 
            /// will always return false and you must ignore the out arguments.
            /// <para>
            /// This alternative method can be used if you have already determined the correct 
            /// Streamable Grid Cell to use to load the Assets for a particular World Cell.
            /// </para>
            /// </summary>
            /// <param name="streamableGridCellToLoad">
            /// The Streamable Grid Cell that is actually being used to load Assets for a given World Cell.
            /// </param>
            /// <param name="chunkIndex">
            /// The index of the chunk you are trying to load.
            /// </param>
            /// <param name="assetKey">
            /// The key produced by the user to try and retrieve the asset load info. Will be set correctly 
            /// so long as the custom addressable chunk streamer does not have asset reuse disabled.
            /// </param>
            /// <param name="info">
            /// If the method returns true, this will contain the info about the async operation handle 
            /// that was used to load the asset to be reused (found in the handles .Result property). 
            /// Note, if you use the Result, you must call IncrementUserCount!</param>
            /// <returns>
            /// Returns true if there is an addressable asset that can be reused by the input 
            /// World Cell, and false if not.
            /// </returns>
            public bool TryGetReusableAssetLoadInfo(Cell streamableGridCellToLoad, int chunkIndex, out int assetKey, out LoadedAsyncOperationInfo info)
            {
                if (!CanReuseAddressables)
                {
                    assetKey = -1;
                    info = null;
                    return false;
                }
                assetKey = GetReusableAssetKey(streamableGridCellToLoad, chunkIndex);
                return TryGetAssetLoadInfo(assetKey, out info);
            }

            /// <summary>
            /// Tries to get information associated with a completed load operation using a specific integer key. If the load operation is 
            /// reusable, you should use one of the 
            /// <see cref="TryGetReusableAssetLoadInfo">TryGetReusableAssetLoadInfo</see> methods instead. 
            /// Otherwise, use this method with the same key 
            /// returned by your implementation of <see cref="GetNonReusableAssetKey">GetNonReusableAssetKey</see>.
            /// </summary>
            /// <param name="key">The key to use to get the information.</param>
            /// <param name="info"></param>
            /// <returns>True if the information could be retrieved, false otherwise.</returns>
            public bool TryGetAssetLoadInfo(int key, out LoadedAsyncOperationInfo info)
            {
                return LoadedAsyncOperations.TryGetValue(key, out info);
            }
            internal void AddLoadedAsyncOpInfo(int key, LoadedAsyncOperationInfo info)
            {
                LoadedAsyncOperations.Add(key, info);
            }
            public void RemoveLoadedAsyncOpInfo(int key, LoadedAsyncOperationInfo info)
            {
                LoadedAsyncOperations.Remove(key);
                info.ResetReturnToPool(loadedAsyncOpInfoPool);
            }

            /// <summary>
            /// Completes any jobs currently running immediately. Note, this may cause a hitch in the frame rate.
            /// </summary>
            public void CompleteAllJobsImmediately()
            {
                if (IsFindLargestChunkJobRunning)
                {
                    OnFindLargestChunkValueJobCompleted();
                }
            }
            public void RemoveUserOfReusableAsset(WorldCell cell, int chunkIndex, out bool handleReleased)
            {
                handleReleased = false;

                if (TryGetReusableAssetLoadInfo(cell, chunkIndex, out _, out int assetKey, out LoadedAsyncOperationInfo info))
                {
                    info.DecrementUserCount();
                    if (!info.HasUsers)
                    {
                        parent.conditionalMembers.OnReleasingAssetChunkHandle(cell, chunkIndex);
                        Addressables.Release(info.handle);
                        parent.conditionalMembers.OnAssetChunkHandleReleased(cell, chunkIndex);
                        RemoveLoadedAsyncOpInfo(assetKey, info);
                        handleReleased = true;
                    }
                }
                else
                    throw new MissingAssetException($"An attempt was made by an Addressable Chunk Streamer to remove a user for a reusable addressable asset resource, but no such asset resource was found. This should not happen. Please contact the developer with the totality of this error message! More Info:\n\nWorld ID: {cell.World.ID}\nWorld Game Object Name: {cell.World.gameObject.name}\nZone: {ZoneGrouping.ZoneIndex}\nWorld Grouping: {cell.WorldGroupingIndex}\nLOD: {cell.LevelOfDetail}\nWorld Grid Cell Index: {cell.CellOnStreamableGrid}\nEndless Grid Cell Index: {cell.CellOnEndlessGrid}\nChunk Index: {chunkIndex}.");
            }

            #endregion

            #region Public Abstract/Virtual Methods

            public virtual void CheckForLoadAndAttachChunksToCellsInSingleFrameExceptions() { }

            /// <summary>
            /// This is called when CanReuseAddressables is implemented to return false, and should return a unique key that 
            /// can be used to store the passed in handle plus some additional information about the load operation used to 
            /// load the addressable asset.
            /// <para>
            /// When chunks associated with a World Cell need to be unloaded, you must be able to produce or access the correct key for the 
            /// chunk stored on the World Cell. Note, however, that if your Chunk Manager uses pooling, or 
            /// has chunk reuse enabled, the chunk stored in the World Cell may have been originally loaded for a different World Cell. Therefore, 
            /// it is imperative to use a key that is associated with the chunks themselves rather than World Cell. If using a chunk that 
            /// derives from UnityEngine.Object, you can use the GetInstanceID to get a unique int that can be used as the key.
            /// </para>
            /// </summary>
            /// <param name="handle">The handle that the key needs to be generated for.</param>
            /// <returns>A unique key associated with the handle or the chunk loaded by the handle.</returns>
            public virtual int GetNonReusableAssetKey(AsyncOperationHandle handle) { return -1; }

            /// <summary>
            /// Should be able to return an AsyncOperationHandle for loading an addressable asset by its IResourceLocation. If you have 
            /// setup your chunk streamer to NOT use IResourceLocations at all, then you can throw an exception in the method body if you want.
            /// </summary>
            /// <param name="location">The IResourceLocation of the asset.</param>
            /// <returns>An AsyncOperationHandle for the load.</returns>
            public abstract AsyncOperationHandle LoadNewAssetAsyncUsingLocation(IResourceLocation location, out bool requiresActivation);

            /// <summary>
            /// Should be able to return an AsyncOperationHandle for loading an addressable asset by a key. If you have 
            /// setup your chunk streamer to NOT use keys at all, then you can throw an exception in the method body if you want.
            /// </summary>
            /// <param name="key">The key to use to load the asset.</param>
            /// <returns>An AsyncOperationHandle for the load.</returns>
            public abstract AsyncOperationHandle LoadNewAssetAsyncUsingKey(string key, out bool requiresActivation);

            /// <summary>
            /// Should activate the Result of an Async Operation Handle when LoadNewAssetAsyncUsingLocation LoadNewAssetAsyncUsingKey 
            /// had requiresActivation set to true. If your implementations of those methods requiresActivation out argument always set it to 
            /// false, you can ignore overriding this method.
            /// </summary>
            /// <param name="handle">The handle with the result to activate</param>
            public virtual void ActivateHandleResult(AsyncOperationHandle handle) { }

            /// <summary>
            /// Should return whether a handle result activated via ActivateHandleResult is ready to be used.
            /// </summary>
            /// <param name="handle"></param>
            /// <returns>True if the result is ready, false otherwise.</returns>
            public virtual bool IsActivatedHandleReady(AsyncOperationHandle handle) { return true; }

            /// <summary>
            /// Should get (from the AsyncOperationHandle) and setup the asset chunk that will be attached to the World Cell. Once the asset is returned it is simply 
            /// attached to the World Cell; no other processing is done with it, so you must ensure the asset is configured exactly 
            /// as you want. For instance, for Game Objects, you should set the name of the object to readyOp.loadedAsyncOpInfo.chunkName.
            /// </summary>
            /// <param name="readyOp">Contains some information about the chunk asset, such as its name.</param>
            /// <param name="handle">The handle used to load the asset, which should contain a reference to the asset. 
            /// Note that typically, this asset is not suitable to be attached to the World Cell. You will likely need to cast the handle to 
            /// the correct type using handle.Convert, then retrieve or instantitate the actual object that will be attached to the 
            /// World Cell (for example, prefab streamers load a GameObject resource, but this resource doesn't actually exist in the scene, 
            /// so a different GameObject must be instantiated from the resource.
            /// </param>
            /// <param name="chunksPositioned">Set to whether you have positioned the chunks or not (if you are not sure, set to Maybe).</param>
            /// <returns>The chunk object to attach to the World Cell</returns>
            public abstract object SetupChunkFromLoadHandle(ReadyOp readyOp, AsyncOperationHandle handle, out ChunksPositioned chunksPositioned);

            #endregion
        }
        #endregion

        #region Enumerator Related Methods

        class AddressablesLoadAndAttachCellsEnumerator : YieldEnumeratorWithParent_RefOnly<AddressableBaseChunkStreamer, List<WorldCell>, AddressableStreamerBaseUser>
        {
            AssetType currentAssetType;
            bool didAttemptRepair;
            IEnumerator<YieldInstruction> errorRepairerEnumerator;
            List<AsyncOperationHandle> handleList;
            List<LoadingOp> recentlyActivatedLoadingOps = new List<LoadingOp>();
            List<bool> boolList;
            float progressIncrementPerChunk, fixedProgress;
            int cellIndex, chunkIndex, currentloadAttempt, asyncOpsStartedThisFrame, postQueueClearPhase, frameLastLoadOpWasCompleted = -1;
            WorldCell currentCell;

            public Action<AsyncOperationHandle> OnAssetLoaded { get; private set; } = null;
            public Dictionary<ChunkCell, WaitingOp> WaitingOps { get; } = new Dictionary<ChunkCell, WaitingOp>();
            public List<ReadyOp> ReadyOps { get; } = new List<ReadyOp>();
            public List<LoadingOp> LoadingOps { get; } = new List<LoadingOp>();//not yet ready to be activated
            public List<LoadingOp> LoadedOpsReadyForActivation { get; } = new List<LoadingOp>();//ready to be activated
            public List<LoadingOp> FailedLoadingOps { get; } = new List<LoadingOp>();
            int TotalLoadingOps { get { return LoadingOps.Count + LoadedOpsReadyForActivation.Count + recentlyActivatedLoadingOps.Count; } }

            protected sealed override void PerformAdditionalIterationPreparation()
            {
                if (OnAssetLoaded == null)
                    OnAssetLoaded = OnAddresableLoadDone;

                r2.SetEnumeratorDriver(this);
                int chunkCount = 0;
                foreach (var cell in r1)
                    chunkCount += cell.NumChunks;

                progressIncrementPerChunk = 1f / chunkCount;
                fixedProgress = 0f;

                Phase = 20;
                cellIndex = asyncOpsStartedThisFrame = 0;
                chunkIndex = 1;
                currentCell = r1[0];
                currentCell.AllChunkAssetsMatchExpectedLOD = true;

                currentAssetType = AssetType.OriginalAsset;
                didAttemptRepair = false;
                currentloadAttempt = 1;
            }

            protected override bool MoveNextImplementation()
            {
                switch (Phase)
                {
                    case 1:
                        {
                            r2.LoadGameObjectAsyncIfNeeded(currentCell, chunkIndex, out bool newAsyncOpStarted);
                            if (newAsyncOpStarted)
                            {
                                //shouldn't ever be greater than, but this is safer so why not?
                                //ops in progress includes ones that haven't reached .9 completion, and those that have but still 
                                //need to be activated
                                if (TotalLoadingOps >= r2.ComparisonReadyMaxConcurrentAsyncLoads)
                                {
                                    asyncOpsStartedThisFrame = 0;
                                    postQueueClearPhase = 4;//will increment chunk once normal execution continues.
                                    Phase = 2;
                                    return true;
                                }
                                else if (++asyncOpsStartedThisFrame >= r2.MaxAsyncLoadOpsToStartInSingleFrame)
                                {
                                    asyncOpsStartedThisFrame = 0;
                                    Phase = 4;
                                    return true;
                                }
                            }

                            goto case 4;
                        }
                    case 2://case that is run when too many async load ops were running.
                        {
                            //unfortunately if there are ops which were activated in this list, it means there final activation 
                            //is an async operation, and the completion of that async operation is unpredictable. Clear this list first 
                            //of any ops that have fully activated
                            if (recentlyActivatedLoadingOps.Count > 0)
                            {
                                for (int i = recentlyActivatedLoadingOps.Count - 1; i > -1; i--)
                                {
                                    if (r2.IsActivatedHandleReady(recentlyActivatedLoadingOps[i].handle))
                                    {
                                        OnLoadingOpComplete(recentlyActivatedLoadingOps[i]);
                                        recentlyActivatedLoadingOps.RemoveAt(i);
                                    }
                                }
                            }

                            //we have to consider any ops which have been activated but whose activation is not complete as still in the process of being 
                            //activated, since they may end up being activated this frame
                            int opsActivated = recentlyActivatedLoadingOps.Count;

                            //check for ops which are almost complete but require activation to complete
                            if (LoadedOpsReadyForActivation.Count > 0)
                            {
                                for (int i = LoadedOpsReadyForActivation.Count - 1; i > -1 && opsActivated < r2.MaxAsyncLoadOpsToCompleteInSingleFrame; i--, opsActivated++)
                                {
                                    var op = LoadedOpsReadyForActivation[i];
                                    LoadedOpsReadyForActivation.RemoveAt(i);
                                    recentlyActivatedLoadingOps.Add(op);

                                    Parent.conditionalMembers.OnInitiatingAssetChunkIntegrate(op.worldCell, op.chunkIndex);
                                    r2.ActivateHandleResult(op.handle);
                                }
                            }

                            //if ops were activated or completed this frame, we don't want to do anything else
                            if (opsActivated > 0 || Time.frameCount == frameLastLoadOpWasCompleted)
                            {
                                SetLoadProgress();
                                return true;
                            }

                            //check if we've gone back under the threshold
                            if (TotalLoadingOps < r2.ComparisonReadyMaxConcurrentAsyncLoads)
                            {
                                Phase = postQueueClearPhase;
                                return MoveNextImplementation();//will cause the post queue phase to run
                            }
                            else
                                return true;//yield a frame then run this case again
                        }
                    case 4:
                        {
                            chunkIndex++;
                            if (chunkIndex <= currentCell.NumChunks)
                                goto case 1;
                            else
                            {
                                cellIndex++;
                                if (cellIndex < r1.Count)
                                {
                                    chunkIndex = 1;
                                    currentCell = r1[cellIndex];
                                    currentCell.AllChunkAssetsMatchExpectedLOD = true;
                                    goto case 1;
                                }
                                else
                                {
                                    Phase = 5;
                                    if (asyncOpsStartedThisFrame > 0)//don't want to do other stuff if an async op was started this frame
                                        return true;
                                    else
                                        goto case 5;
                                }
                            }
                        }
                    case 5:
                        {
                            //clear ops which have fully activated from the recentlyActivatedLoadingOps list.
                            if (recentlyActivatedLoadingOps.Count > 0)
                            {
                                //we can do as many of these as there are
                                for (int i = recentlyActivatedLoadingOps.Count - 1; i > -1; i--)
                                {
                                    if (r2.IsActivatedHandleReady(recentlyActivatedLoadingOps[i].handle))
                                    {
                                        OnLoadingOpComplete(recentlyActivatedLoadingOps[i]);
                                        recentlyActivatedLoadingOps.RemoveAt(i);
                                    }
                                }
                            }

                            int opsActivated = recentlyActivatedLoadingOps.Count;

                            //activate handle results that need to be activated, since these block the loading thread.
                            if (LoadedOpsReadyForActivation.Count > 0)
                            {
                                for (int i = LoadedOpsReadyForActivation.Count - 1; i > -1 && opsActivated < r2.MaxAsyncLoadOpsToCompleteInSingleFrame; i--, opsActivated++)
                                {
                                    var op = LoadedOpsReadyForActivation[i];
                                    LoadedOpsReadyForActivation.RemoveAt(i);
                                    recentlyActivatedLoadingOps.Add(op);

                                    Parent.conditionalMembers.OnInitiatingAssetChunkIntegrate(op.worldCell, op.chunkIndex);
                                    r2.ActivateHandleResult(op.handle);
                                }
                            }

                            //if any async ops were completed this frame, exit now, as we don't want to do anythign else
                            if (opsActivated > 0 || Time.frameCount == frameLastLoadOpWasCompleted)
                            {
                                SetLoadProgress();
                                return true;
                            }

                            //Ready Ops are only available when an addressable asset has been loaded and activated
                            if (ReadyOps.Count > 0)
                            {
                                for (int i = ReadyOps.Count - 1, chunksSetup = 0; i > -1 && chunksSetup < r2.MaxChunksToConfigureInSingleFrame; i--, chunksSetup++)
                                {
                                    var readyOp = ReadyOps[i];
                                    ReadyOps.RemoveAt(i);

                                    readyOp.loadedAsyncOpInfo.IncrementUserCount();

                                    if (!readyOp.loadedAsyncOpInfo.isCorrectChunkAsset)
                                        readyOp.cell.AllChunkAssetsMatchExpectedLOD = false;

                                    Parent.conditionalMembers.OnConfiguringAssetChunk(readyOp.cell, readyOp.chunkIndex);
                                    object obj = r2.SetupChunkFromLoadHandle(readyOp, readyOp.loadedAsyncOpInfo.handle, out ChunksPositioned objPositioned);
                                    readyOp.cell.AttachChunkToCell(obj, objPositioned, readyOp.chunkIndex);
                                    Parent.conditionalMembers.OnAssetChunkConfigured(readyOp.cell, readyOp.chunkIndex);
                                    readyOp.ResetAndReturnToPool(readyOpPool);

                                    fixedProgress += progressIncrementPerChunk;
                                }

                                //since at least one chunk was setup, yield
                                SetLoadProgress();
                                return true;

                            }//there are no ready ops

                            //getting here means we did not process any loading ops ready for activation or ready ops, and that there were no remaining recentlyActivatedLoadingOps
                            if (LoadingOps.Count > 0)//are there any ops loading? wait for them to finish
                            {
                                SetLoadProgress();
                                return true;
                            }
                            else if (FailedLoadingOps.Count > 0)//all loading ops finished, but some have failed
                            {
                                if (currentAssetType == AssetType.OriginalAsset)
                                {
                                    if (didAttemptRepair)
                                    {
                                        //if we have already attempted a repair, we just need to treat it as a failure and try and load the backup assets
                                        goto OnFailure;
                                    }
                                    else
                                    {
                                        if (currentloadAttempt == Parent.MaxLoadAttempts)
                                        {
                                            if (Parent.ErrorRepairer != null)
                                            {
                                                didAttemptRepair = true;
                                                handleList = Parent.HandleListPool.WithdrawObject();
                                                boolList = Parent.BoolListPool.WithdrawObject();

                                                PrintErrorsForFailedOpsIfNeeded();
                                                foreach (var failedOp in FailedLoadingOps)
                                                    handleList.Add(failedOp.handle);

                                                errorRepairerEnumerator = Parent.ErrorRepairer.AttemptRepair(handleList, boolList);
                                                Phase = 14;
                                                goto case 14;
                                            }
                                            else//no error repairer so it's a failure
                                                goto OnFailure;
                                        }
                                        else
                                        {
                                            PrintErrorsForFailedOpsIfNeeded();
                                            currentloadAttempt++;
                                            goto case 11;//attempt reload of original assets
                                        }
                                    }

OnFailure:
                                    if (r2.UseAltLODFailSafe)
                                    {
                                        PrintErrorsForFailedOpsIfNeeded();
                                        goto case 12;
                                    }
                                    else if (r2.UsePlaceholderFailSafe)
                                    {
                                        PrintErrorsForFailedOpsIfNeeded();
                                        goto case 13;
                                    }
                                    else
                                        goto case 16;//throw exeption
                                }
                                else if (currentAssetType == AssetType.LowestQualityLODAsset)
                                {
                                    if (r2.UsePlaceholderFailSafe)
                                    {
                                        PrintErrorsForFailedOpsIfNeeded();
                                        goto case 13;
                                    }
                                    else
                                        goto case 16;//throw exception
                                }//just tried to load lowest quality LOD
                                else
                                {
                                    goto case 16;//throw exception
                                }//just tried to load place holder
                            }
                            else//no more ops. All done!
                            {
                                //for(int c = 0; c < r1.Count; c++)
                                //{
                                //    if (r1[c].GetChunkBelongingToCell(1) == null)
                                //        Debug.LogError($"Loading operation is complete but found a cell that does not have an asset chunk. Cell is {r1[c]}");
                                //}
                                return false;
                            }
                        }
                    case 11://attempt to reload the failed ops with the original assets
                        {
                            Phase = 17;
                            goto case 17;
                        }
                    case 12://attempt to load lowest quality LOD for failed ops
                        {
                            currentAssetType = AssetType.LowestQualityLODAsset;
                            Phase = 18;
                            goto case 18;
                        }
                    case 13://attempt to load place holder asset for failed ops
                        {
                            currentAssetType = AssetType.PlaceholderAsset;
                            Phase = 19;
                            goto case 19;
                        }
                    case 14://error repairer MoveNext
                        {
                            if (errorRepairerEnumerator.MoveNext())
                            {
                                Current = errorRepairerEnumerator.Current;
                                return true;
                            }
                            else
                            {
                                errorRepairerEnumerator = null;
                                Phase = 15;
                                goto case 15;
                            }
                        }
                    case 15://Post Error Repairer Routine
                        {
                            //clear and return handle list to pool, as it's no longer needed
                            //this case can be triggered multiple times, and handle list should only be cleared once.
                            if (handleList != null)
                            {
                                handleList.Clear();
                                Parent.HandleListPool.DepositObject(handleList);
                                handleList = null;
                            }
                            //loop through and see which handles errors were repaired.
                            //if repaired, remove from failed ops list and try to redownload the original
                            int opsStarted = 0;
                            for (int i = FailedLoadingOps.Count - 1; i > -1; i--)
                            {
                                if (boolList[i])//successfully repaired
                                {
                                    var repairedOp = FailedLoadingOps[i];
                                    FailedLoadingOps.RemoveAt(i);
                                    RedownloadOriginal(repairedOp);

                                    if (TotalLoadingOps >= r2.ComparisonReadyMaxConcurrentAsyncLoads)
                                    {
                                        postQueueClearPhase = 15;
                                        Phase = 2;
                                        return true;
                                    }
                                    else if (++opsStarted >= r2.MaxAsyncLoadOpsToStartInSingleFrame)
                                    {
                                        //phase already set to 15
                                        return true;
                                    }
                                }
                            }

                            boolList.Clear();
                            Parent.BoolListPool.DepositObject(boolList);
                            boolList = null;

                            Phase = 5;
                            if (opsStarted > 0)
                                return true;
                            else
                                goto case 5;
                        }
                    case 16://Exception
                        {
                            foreach (var failedOp in FailedLoadingOps)
                                Debug.Log(r2.GetPrintError(failedOp, currentAssetType, failedOp.location != null ? failedOp.location.PrimaryKey : failedOp.key));
                            //in that case, we just throw an exception since we shouldn't fail at loading the placeholder

                            FailedLoadingOps.Clear();
                            LoadedOpsReadyForActivation.Clear();
                            LoadingOps.Clear();
                            WaitingOps.Clear();
                            r2.SetEnumeratorDriver(null);
                            throw new MissingAssetException("One or more addressable assets could not be downloaded and/or loaded. You should see more red error messages in the console indicating every asset that failed.");
                        }
                    case 17://try re-downloading original asset
                        {
                            int opsStarted = 0;
                            for (int i = FailedLoadingOps.Count - 1; i > -1; i--)
                            {
                                var failedOp = FailedLoadingOps[i];
                                FailedLoadingOps.RemoveAt(i);
                                RedownloadOriginal(failedOp);
                                if (TotalLoadingOps >= r2.ComparisonReadyMaxConcurrentAsyncLoads)
                                {
                                    postQueueClearPhase = 17;
                                    Phase = 2;
                                    return true;
                                }
                                else if (++opsStarted >= r2.MaxAsyncLoadOpsToStartInSingleFrame)
                                {
                                    //phase already set to 17
                                    return true;
                                }
                            }

                            Phase = 5;
                            if (opsStarted > 0)
                                return true;
                            else
                                goto case 5;
                        }
                    case 18://try downloading lowest quality LOD asset
                        {
                            int opsStarted = 0;
                            for (int i = FailedLoadingOps.Count - 1; i > -1; i--)
                            {
                                var failedOp = FailedLoadingOps[i];
                                FailedLoadingOps.RemoveAt(i);
                                DownloadLowestQualityLOD(failedOp);
                                if (TotalLoadingOps >= r2.ComparisonReadyMaxConcurrentAsyncLoads)
                                {
                                    postQueueClearPhase = 18;
                                    Phase = 2;
                                    return true;
                                }
                                else if (++opsStarted >= r2.MaxAsyncLoadOpsToStartInSingleFrame)
                                {
                                    //phase already set to 18
                                    return true;
                                }
                            }

                            Phase = 5;
                            if (opsStarted > 0)
                                return true;
                            else
                                goto case 5;
                        }
                    case 19://try downloading place holder assets
                        {
                            int opsStarted = 0;
                            for (int i = FailedLoadingOps.Count - 1; i > -1; i--)
                            {
                                var failedOp = FailedLoadingOps[i];
                                FailedLoadingOps.RemoveAt(i);
                                DownloadPlaceholder(failedOp);
                                if (TotalLoadingOps >= r2.ComparisonReadyMaxConcurrentAsyncLoads)
                                {
                                    postQueueClearPhase = 19;
                                    Phase = 2;
                                    return true;
                                }
                                else if (++opsStarted >= r2.MaxAsyncLoadOpsToStartInSingleFrame)
                                {
                                    //phase already set to 19
                                    return true;
                                }
                            }

                            Phase = 5;
                            if (opsStarted > 0)
                                return true;
                            else
                                goto case 5;
                        }
                    case 20://waiting case
                        {
                            if (r2.IsWaitingOnJob)
                                return true;
                            else
                            {
                                Phase = 1;
                                goto case 1;
                            }
                        }
                    default:
                        throw new YieldEnumeratorException("AddressablesLoadAndAttachCellsEnumerator", "Addressable Asset Prefab Streamer component", Parent.gameObject.name, Phase);
                }
            }

            protected sealed override void ResetImplementation()
            {
                Parent.LoadProgress = 1f;
                currentCell = null;
                r2.SetEnumeratorDriver(null);
            }

            void OnAddresableLoadDone(AsyncOperationHandle handle)
            {
                for (int i = 0; i < LoadingOps.Count; i++)
                {
                    if (LoadingOps[i].handle.Equals(handle))
                    {
                        //we will always remove the load op regardless of whether it succeeded
                        var loadedOp = LoadingOps[i];
                        LoadingOps.RemoveAt(i);

                        if (loadedOp.handle.Status == AsyncOperationStatus.Succeeded)
                        {
                            if (loadedOp.requiresActivation)
                                LoadedOpsReadyForActivation.Add(loadedOp);
                            else
                                OnLoadingOpComplete(loadedOp);
                        }
                        else
                        {
                            FailedLoadingOps.Add(loadedOp);
                        }

                        return;
                    }
                }
            }

            void OnLoadingOpComplete(LoadingOp completedLoadingOp)
            {
                //only track loading if it's not the correct asset for the chunk
                if (completedLoadingOp.isCorrectAssetForChunk)
                    Parent.conditionalMembers.OnAssetChunkLoaded(completedLoadingOp.worldCell, completedLoadingOp.chunkIndex);

                WaitingOp waitingOpInChain = WaitingOps[completedLoadingOp.waitingOpsRetrievalKey];
                WaitingOps.Remove(completedLoadingOp.waitingOpsRetrievalKey);

                var loadedAsyncOpInfo = loadedAsyncOpInfoPool.WithdrawObject();
                loadedAsyncOpInfo.handle = completedLoadingOp.handle;
                loadedAsyncOpInfo.chunkName = completedLoadingOp.chunkName;
                loadedAsyncOpInfo.isCorrectChunkAsset = completedLoadingOp.isCorrectAssetForChunk;

                int loadedAsyncOpKey;
                if (r2.CanReuseAddressables)
                    loadedAsyncOpKey = r2.GetReusableAssetKey(completedLoadingOp.loadedStreamableGridCell, completedLoadingOp.chunkIndex);
                else
                    loadedAsyncOpKey = r2.GetNonReusableAssetKey(completedLoadingOp.handle);

                r2.AddLoadedAsyncOpInfo(loadedAsyncOpKey, loadedAsyncOpInfo);
                while (waitingOpInChain != null)
                {
                    var readyOp = readyOpPool.WithdrawObject();
                    readyOp.cell = waitingOpInChain.cell;
                    readyOp.chunkIndex = completedLoadingOp.chunkIndex;
                    readyOp.loadedAsyncOpInfo = loadedAsyncOpInfo;
                    ReadyOps.Add(readyOp);

                    var prevOpInChain = waitingOpInChain;
                    waitingOpInChain = prevOpInChain.nextInChain;
                    prevOpInChain.ResetAndReturnToPool(waitingOpPool);
                }

                completedLoadingOp.ResetAndReturnToPool(loadingOpPool);
                frameLastLoadOpWasCompleted = Time.frameCount;
            }

            void RedownloadOriginal(LoadingOp op)
            {
                Addressables.Release(op.handle);//release the other handle first

                Parent.conditionalMembers.OnInitiatingAssetChunkLoad(op.worldCell, op.chunkIndex);
                bool requiresActivation;
                if (op.location != null)
                    op.handle = r2.LoadNewAssetAsyncUsingLocation(op.location, out requiresActivation);
                else
                    op.handle = r2.LoadNewAssetAsyncUsingKey(op.key, out requiresActivation);

                Parent.conditionalMembers.OnAssetChunkLoadInitiated(op.worldCell, op.chunkIndex);

                op.requiresActivation = requiresActivation;
                op.handle.Completed += OnAssetLoaded;

                LoadingOps.Add(op);
            }

            void DownloadLowestQualityLOD(LoadingOp op)
            {
                Addressables.Release(op.handle);//release the other handle first

                //the lowest quality LOD may use less chunks than this LOD, so we need to make sure the chunk index is not too large.
                //if it is, we simply set it to the last chunk for the LOD
                int chunk = op.chunkIndex;
                int numChunksOnCell = r2.LowestQualityLODGridDetails.GetCellChunksUsingStreamableGridCell(op.loadedStreamableGridCell);
                if (chunk > numChunksOnCell)
                    chunk = numChunksOnCell;

                op.handle = r2.StreamerOfLowestQualityLODs.LoadAssetForCell(op.loadedStreamableGridCell, chunk, r2.StreamerUserIDForLowestQualityLODs, out _, out IResourceLocation location, out string key, out bool requiresActivation);

                op.requiresActivation = requiresActivation;
                op.handle.Completed += OnAssetLoaded;

                //note we do not get the chunkName from the method, because that would be the chunk name of the asset from the lowest quality 
                //lod, and we still want to name this chunk as if it were from this LOD.

                //these two operations are probably unecessary
                op.location = location;
                op.key = key;

                //we need to mark down that the op is loaded an asset that does not match the chunk asset
                op.isCorrectAssetForChunk = false;
                LoadingOps.Add(op);
            }

            void DownloadPlaceholder(LoadingOp op)
            {
                Addressables.Release(op.handle);//release the other handle first
                op.handle = r2.LoadNewAssetAsyncUsingLocation(r2.PlaceholderLocation, out bool requiresActivation);
                op.handle.Completed += OnAssetLoaded;
                op.requiresActivation = requiresActivation;
                op.location = r2.PlaceholderLocation;
                op.key = null;

                //we need to mark down that the op is loaded an asset that does not match the chunk asset
                //this is redundant if we just tried loading lowest quality LOD assets, however there is a chance 
                //that the streamer went from trying to load the original to trying to load the place holder, so we need to 
                //mark it regardless
                op.isCorrectAssetForChunk = false;
                LoadingOps.Add(op);
            }

            void PrintErrorsForFailedOpsIfNeeded()
            {
                if (!Parent.PrintErrorToConsole)
                    return;

                foreach (var op in FailedLoadingOps)
                    Debug.LogError(r2.GetPrintError(op, currentAssetType, op.location != null ? op.location.PrimaryKey : op.key));
            }

            void SetLoadProgress()
            {
                float loadingProgress = 0f;
                foreach (var loadingOp in LoadingOps)
                    loadingProgress += loadingOp.handle.PercentComplete * progressIncrementPerChunk * .9f;

                foreach (var loadingOp in LoadedOpsReadyForActivation)
                    loadingProgress += loadingOp.handle.PercentComplete * progressIncrementPerChunk * .9f;

                foreach (var loadingOp in recentlyActivatedLoadingOps)
                    loadingProgress += loadingOp.handle.PercentComplete * progressIncrementPerChunk * .9f;

                foreach (var readyOp in ReadyOps)
                    loadingProgress += progressIncrementPerChunk * .95f;

                Parent.LoadProgress = fixedProgress + loadingProgress;
            }
        }

        #endregion
    }
}