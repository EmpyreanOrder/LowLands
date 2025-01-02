//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using System;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEngine.ResourceManagement.AsyncOperations;
    using UnityEngine.ResourceManagement.Exceptions;


    /// <summary>
    /// An optional class which can be overriden to provide custom repair logic for failed addressable download operations. Basically, when one or more 
    /// downloads fail, this classes AttemptRepair method will be called to try to fix the errors causing the failed downloads. If repairs were successfull, 
    /// the Addressable Streamer you are using will attempt to redownload the assets. Repair is only attempted once, after which the error handling 
    /// logic will be triggered.
    /// <para>
    /// The errors reported should be on of the following, however there is no gaurantee. You should check for one of these errors first and if not found, 
    /// move on to trying to identify the error a different way. We cannot offer any advice on how to resolve/fix any of these errors.
    /// </para>
    /// <para>
    /// "Request aborted" 
    /// "Unable to write data" 
    /// "Malformed URL" 
    /// "Out of memory" 
    /// "No Internet Connection" 
    /// "Encountered invalid redirect (missing Location header?)" 
    /// "Cannot modify request at this time" 
    /// "Unsupported Protocol" 
    /// "Destination host has an erroneous SSL certificate" 
    /// "Unable to load SSL Cipher for verification" 
    /// "SSL CA certificate error" 
    /// "Unrecognized content-encoding" 
    /// "Request already transmitted" 
    /// "Invalid HTTP Method" 
    /// "Header name contains invalid characters" 
    /// "Header value contains invalid characters" 
    /// "Cannot override system-specified headers" 
    /// "Backend Initialization Error" 
    /// "Cannot resolve proxy" 
    /// "Cannot resolve destination host" 
    /// "Cannot connect to destination host" 
    /// "Access denied" 
    /// "Generic/unknown HTTP error" 
    /// "Unable to read data" 
    /// "Request timeout" 
    /// "Error during HTTP POST transmission" 
    /// "Unable to complete SSL connection" 
    /// "Redirect limit exceeded" 
    /// "Received no data in response" 
    /// "Destination host does not support SSL" 
    /// "Failed to transmit data" 
    /// "Failed to receive data" 
    /// "Login failed" 
    /// "SSL shutdown failed" 
    /// "Redirect limit is invalid" 
    /// "Not implemented"
    /// "Data Processing Error, see Download Handler error" 
    /// "Unknown Error"
    /// </para>
    /// </summary>
    /// <title>
    /// AddressableErrorRepairer Class
    /// </title>
    /// <category>
    /// Secondary Components
    /// </category>
    /// <navigationName>
    /// AddressableErrorRepairer
    /// </navigationName>
    /// <fileName>AddressableErrorRepairer.html</fileName>
    /// <syntax>
    /// public abstract class AddressableErrorRepairer : MonoBehaviour
    /// </syntax>
    public abstract class AddressableErrorRepairer : MonoBehaviour
    {
        /// <summary>
        /// Method used to attempt a repair of any errors that caused the addressable asset downloads to fail. Since multiple downloads can fail, 
        /// the method takes in a list of AsyncOperationHandles, each representing a failed download. You can use the GetDownloadError method to retrieve 
        /// a useful error message that you may be able to use to figure out what is goign on, however you should check to ensure the error message 
        /// returned by this method is not null or empty before attempting to use it.
        /// <para>
        /// These error messages may be all the same, or 
        /// they may be different. You may just need to fix one issue, or fix multiple issues. When the method is invoked, errorsRepaired will be empty. 
        /// For each handle, you must add to the errorsRepaired list either true or false. True indicating that the error that caused the download to fail
        /// was successfully repaired, false indicating that it was not. The order of this list must match the order of the errorMessages list 1 to 1.
        /// </para>
        /// <para>
        /// After the method finishes executing, the Addressable Streamer will attempt to redownload (one attempt only) assets for handles who's errors were repaired. 
        /// If an error was not repaired, the streamer will try to load the lowest quality LOD asset or a Place Holder asset for the associated cell chunk, 
        /// depending on the configuration of the Streamable Grid and Streamer's Fail-Safe. If fail-safe assets are not being used or cannot be downloaded, an exception 
        /// is thrown.
        /// </para>
        /// </summary>
        /// <param name="failedHandles">The list of handles that failed.</param>
        /// <param name="errorsRepaired">The list detailing whether each error that caused each download to fail was repaired.</param>
        /// <returns type = "IEnumerator&lt;YieldInstruction&gt;">
        /// An IEnumerator&lt;YieldInstruction&gt; that can be iterated over or used as a coroutine. See the 
        /// <see href="YieldInstruction.html">YieldInstruction</see> page for more info.
        /// </returns>
        /// <displayName id="HandleException">
        /// HandleException(AsyncOperationHandle, Exception)
        /// </displayName>
        /// <syntax>
        /// public ReturnType HandleException(AsyncOperationHandle handle, Exception exception)
        /// </syntax>
        public abstract IEnumerator<YieldInstruction> AttemptRepair(List<AsyncOperationHandle> failedHandles, List<bool> errorsRepaired);

        /*
         *This is a sample method you can copy/paste to your custom error repairer. It includes a switch statement that has all possible 
         *errors that can be returned by GetDownloadError (at the present time. Unity may update these errors so check the website to make sure they 
         *are still correct!).
         *
         *If you do know how to handle an error, or don't want to, remove the case statement for that handle. The default case statement will 
         *trigger for the error and the error will be marked as not repaired.
        public sealed override IEnumerator<YieldInstruction> AttemptRepair(List<AsyncOperationHandle> failedHandles, List<bool> errorsRepaired)
        {
            foreach(var handle in failedHandles)
            {
                string error = GetDownloadError(handle);
                if(string.IsNullOrEmpty(error))
                {
                    errorsRepaired.Add(false);
                    continue;
                }

                switch(error)
                {
                    case "Request aborted":
                        {
                            //If you can fix an error, add true to errorsRepaired.
                            //If you cannot, add false.
                            //If you are not sure how to handle the error, remove the case for it and the default case will be triggered for that error
                            break;
                        }
                    case "Unable to write data":
                        {

                            break;
                        }
                    case "Malformed URL":
                        {

                            break;
                        }
                    case "Out of memory":
                        {

                            break;
                        }
                    case "No Internet Connection":
                        {

                            break;
                        }
                    case "Encountered invalid redirect (missing Location header?)":
                        {

                            break;
                        }
                    case "Cannot modify request at this time":
                        {

                            break;
                        }
                    case "Unsupported Protocol":
                        {

                            break;
                        }
                    case "Destination host has an erroneous SSL certificate":
                        {

                            break;
                        }
                    case "Unable to load SSL Cipher for verification":
                        {

                            break;
                        }
                    case "SSL CA certificate error":
                        {

                            break;
                        }
                    case "Unrecognized content-encoding":
                        {

                            break;
                        }
                    case "Request already transmitted":
                        {

                            break;
                        }
                    case "Invalid HTTP Method":
                        {

                            break;
                        }
                    case "Header name contains invalid characters":
                        {

                            break;
                        }
                    case "Header value contains invalid characters":
                        {

                            break;
                        }
                    case "Cannot override system-specified headers":
                        {

                            break;
                        }
                    case "Backend Initialization Error":
                        {

                            break;
                        }
                    case "Cannot resolve proxy":
                        {

                            break;
                        }
                    case "Cannot resolve destination host":
                        {

                            break;
                        }
                    case "Cannot connect to destination host":
                        {

                            break;
                        }
                    case "Access denied":
                        {

                            break;
                        }
                    case "Generic/unknown HTTP error":
                        {

                            break;
                        }
                    case "Unable to read data":
                        {

                            break;
                        }
                    case "Request timeout":
                        {

                            break;
                        }
                    case "Error during HTTP POST transmission":
                        {

                            break;
                        }
                    case "Unable to complete SSL connection":
                        {

                            break;
                        }
                    case "Redirect limit exceeded":
                        {

                            break;
                        }
                    case "Received no data in response":
                        {

                            break;
                        }
                    case "Destination host does not support SSL":
                        {

                            break;
                        }
                    case "Failed to transmit data":
                        {

                            break;
                        }
                    case "Failed to receive data":
                        {

                            break;
                        }
                    case "Login failed":
                        {

                            break;
                        }
                    case "SSL shutdown failed":
                        {

                            break;
                        }
                    case "Redirect limit is invalid":
                        {

                            break;
                        }
                    case "Not implemented":
                        {

                            break;
                        }
                    case "Data Processing Error, see Download Handler error":
                        {

                            break;
                        }
                    case "Unknown Error":
                        {

                            break;
                        }
                    default:
                        {
                            //Good Idea to log the error you could not handle here
                            errorsRepaired.Add(false);
                            break;
                        }
                }

                //You do not need to have any yield statements, they are intended to give you time to fix errors since fixing may take multiple frames.
                //If you do not need to yield, keep the following line which will stop the compiler from auto-generating an enumerator class 
                //for this method (this will also stop garbage from being generated when the method is called).
                return SimpleYieldBreakEquivalentEnumerator.Instance;
            }
        }
        */

        /// <summary>
        /// Gets the Remote Provider Exception Web Result Error if available. If not available, returns null.
        /// </summary>
        /// <param name="fromHandle">
        /// The handle to retrieve the error message from.
        /// </param>
        /// <returns type="string">
        /// The error message or null if it is not available.
        /// </returns>
        /// <displayName id="GetDownloadError">
        /// GetDownloadError(AsyncOperationHandle)
        /// </displayName>
        /// <syntax>
        /// public static string GetDownloadError(AsyncOperationHandle fromHandle)
        /// </syntax>
        public static string GetDownloadError(AsyncOperationHandle fromHandle)
        {
            //method should only be called when status is failed
            //if (fromHandle.Status != AsyncOperationStatus.Failed)
            //    return null;

            RemoteProviderException remoteException;
            Exception e = fromHandle.OperationException;
            while (e != null)
            {
                remoteException = e as RemoteProviderException;
                if (remoteException != null)
                    return remoteException.WebRequestResult.Error;
                e = e.InnerException;
            }
            return null;
        }
    }
}