//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using System;
    using UnityEngine;
    using UnityEngine.ResourceManagement.AsyncOperations;

    /// <summary>
    /// This class can be used to provide the Addressable Streamer you are using with a custom method for exception handling. If you do not provide this 
    /// class, and Log Runtime Exceptions is enabled in your Addressable Settings, the streamers will only log Invalid Key Exceptions. Usually you 
    /// will not need to provide a custom exception handler, however the option is there if you want it.
    /// <para>
    /// </para>
    /// </summary>
    /// <title>
    /// AddressableExceptionHandler Class
    /// </title>
    /// <category>
    /// Secondary Components
    /// </category>
    /// <navigationName>
    /// AddressableExceptionHandler
    /// </navigationName>
    /// <fileName>AddressableExceptionHandler.html</fileName>
    /// <syntax>
    /// public abstract class AddressableExceptionHandler : MonoBehaviour
    /// </syntax>
    public abstract class AddressableExceptionHandler : MonoBehaviour
    {
        /// <summary>
        /// Override to provide custom exception handling for failed async operations using one of the addressable chunk streamers
        /// </summary>
        /// <param name="handle" type="AsyncOperationHandle">
        /// The handle for the async operation that failed.
        /// </param>
        /// <param name="exception" type ="Exception">
        /// The exception that was thrown during the failed load op.
        /// </param>
        /// <displayName id="HandleException">
        /// HandleException(AsyncOperationHandle, Exception)
        /// </displayName>
        /// <syntax>
        /// public abstract void HandleException(AsyncOperationHandle handle, Exception exception)
        /// </syntax>
        public abstract void HandleException(AsyncOperationHandle handle, Exception exception);

        //Example Handling - skips logging all exceptions except Invalid Key Exception
        //public sealed override void HandleException(AsyncOperationHandle handle, Exception exception)
        //{
        //    if (exception.GetType() == typeof(InvalidKeyException))
        //        Addressables.LogException(handle, exception);
        //}
    }
}