using UnityEngine;

namespace DynamicFogAndMist2 {

    public static class Tools {

        public static Color ColorBlack = Color.black;
        public static void CheckCamera(ref Camera cam) {
            if (cam != null) return;
            cam = Camera.main;
            if (cam == null) {
                Camera[] cameras = Misc.FindObjectsOfType<Camera>();
                for (int k = 0; k < cameras.Length; k++) {
                    if (cameras[k].isActiveAndEnabled && cameras[k].gameObject.activeInHierarchy) {
                        cam = cameras[k];
                        return;
                    }

                }
            }
        }

        public static DynamicFogManager CheckMainManager() {
            DynamicFogManager fog2 = Misc.FindObjectOfType<DynamicFogManager>();
            if (fog2 == null) {
                GameObject go = new GameObject();
                fog2 = go.AddComponent<DynamicFogManager>();
                go.name = fog2.managerName;
            }
            return fog2;
        }


        public static void CheckManager<T>(ref T manager) where T : Component {
            if (manager == null) {
                manager = Misc.FindObjectOfType<T>();
                if (manager == null) {
                    DynamicFogManager root = CheckMainManager();
                    if (root != null) {
                        manager = Misc.FindObjectOfType<T>();
                    }
                    if (manager == null) {
                        GameObject o = new GameObject();
                        o.transform.SetParent(root.transform, false);
                        manager = o.AddComponent<T>();
                        o.name = ((IDynamicFogManager)manager).managerName;
                    }
                }
            }
        }
    }

}