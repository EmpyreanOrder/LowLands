﻿using MalbersAnimations.Controller;
using MalbersAnimations.Scriptables;
using MalbersAnimations.Utilities;
using System.Collections.Generic;
using UnityEngine;

namespace MalbersAnimations
{
    /// <summary>Ladder Logic for the Animal Controller</summary>
    [AddTypeMenu("Human/Ladder")]
    public class Ladder : State
    {
        public override string StateName => "Human/Ladder";
        public override string StateIDName => "Ladder";

        /// <summary>Air Resistance while falling</summary>
        [Header("Ladder Parameters"), Space]
        [Tooltip("Layer to identify climbable surfaces")]
        public LayerReference ClimbLayer = new(1);

        [Tooltip("This is the distance to align the character to the ladder while climbing")]
        public float LadderDistance = 0.3f;


        [Tooltip("Transform Created to Store the Hit Position of the Climb Rays. Use it to show UI When a WAll ")]
        public string HitTransform = "LadderHit";
        private Transform m_HitTransform;

        [Header("State Enter Status")]
        public int BottomEnter = 1;
        public int TopEnter = 2;
        public int MiddleEnter = 3;

        [Header("State Exit Status")]
        public int BottomExit = 1;
        public int TopExit = 2;
        public int MiddleExit = 3;

        [Tooltip("If the Character is on the MaxStep - this value then Exit on the Top of the Ladder")]
        public int TopExitStep = 5;

        [Tooltip("Start Aligning the correct distance to the ladder if entering from the top")]
        public float TopAlignTime = 1f;
        [Tooltip("If the Character is on this LadderStep then Exit on the Bottom of the Ladder")]
        public int BottomExitStep = 1;

        [Header("Check Ceiling")]
        public bool CheckCeiling = true;
        [Hide(nameof(CheckCeiling))] public float CeilingRay = 0.5f;
        [Hide(nameof(CheckCeiling))] public LayerReference CeilingLayer = new(1);
        [Hide(nameof(CheckCeiling))] public QueryTriggerInteraction collide = QueryTriggerInteraction.Ignore;


        [Header("Repositioning")]
        [Tooltip("If the Character is not moving then try to reposition to the closes Ladder Step")]
        public bool RepositionOnIdle = true;
        [Hide(nameof(RepositionOnIdle))]
        public float RepositionOffset = 0;

        [Header("Align Enter Parameters")]
        public float alignTime = 0.25f;
        [Tooltip("Smoothness value to align the animal to the wall")]
        public float AlignSmoothness = 10f;

        public int CurrentStep { get; private set; }

        /// <summary> Store Current Camera Input</summary>
        public bool UsingCameraInput { get; private set; }
        public MLadder MLadder { get; private set; }
        //{
        //    get => mladder;
        //    set
        //    {
        //        mladder = value;
        //       // Debug.Log("mladder = " + mladder);
        //    }
        //}
        //private MLadder mladder;

        public override void AwakeState()
        {
            base.AwakeState();

            if (HitTransform == string.Empty) HitTransform = "LadderHit";

            m_HitTransform = animal.transform.FindGrandChild(HitTransform);

            if (m_HitTransform == null)
            {
                m_HitTransform = new GameObject(HitTransform).transform;
                m_HitTransform.parent = transform;
                m_HitTransform.ResetLocal();
            }

            EnableHitTransform(false);
        }

        /// <summary> Using this to show if a surface can be climb  </summary>
        private void EnableHitTransform(bool v) => m_HitTransform.gameObject.SetActive(v);


        public override bool TryActivate()
        {
            if (MLadder)
            {
                m_HitTransform.position = MTools.ClosestPointOnLine((animal.Center + transform.up * Height), MLadder.TopPos, MLadder.BottomPos);
                EnableHitTransform(!MLadder.NearBottomEntry(transform) && animal.Grounded || Vector3.Angle(MLadder.transform.forward, animal.Forward) < 90);

            }

            return base.TryActivate();
        }


        public override void StatebyInput()
        {
            if (MLadder == null) return;

            if (InputValue)
            {
                //Check if the Ladder is in front of the Animal when is on the bottom or if in the top is facing the opposite direction
                if (!MLadder.NearBottomEntry(transform) && animal.Grounded || Vector3.Angle(MLadder.transform.forward, animal.Forward) < 90)
                {
                    Activate();
                }
                else
                {
                    Debugging("The Character needs to be in front of the ladder when entering from the bottom", "Red");
                }
            }
        }

        /// <summary> Exit the State with an Input </summary>
        public override void StateExitByInput()
        {
            base.StateExitByInput();
        }

        public override void EnterCoreAnimation()
        {
            SetEnterStatus(0);
        }

        private MInteractor interactor;

        public override void OnAnimalEnabled()
        {
            interactor = animal.FindInterface<MInteractor>();

            if (interactor)
            {
                interactor.OnFocusing += OnInteractableEnter;
                interactor.OnUnFocusing += OnInteractableExit;
            }
        }

        public override void OnAnimalDisabled()
        {
            if (interactor)
            {
                interactor.OnFocusing -= OnInteractableEnter;
                interactor.OnUnFocusing -= OnInteractableExit;
            }
        }


        //Called by the Animator
        public override void AllowStateExit()
        {
            animal.UseCameraInput = UsingCameraInput;
            animal.LockHorizontalMovement = false;
            animal.CheckIfGrounded();
            //Debug.Log("LadderExit");
            // MLadder = null;
        }

        private bool IsBottomEntry;

        public override void Activate()
        {

            //If we have not found a Ladder then search it on a zone
            if (MLadder == null && animal.InZone)
            {
                MLadder = animal.Zone.transform.FindComponent<MLadder>();
            }

            if (MLadder)
            {
                //Find the Correct Enter Status on the Ladder (IF GROUNDED)
                if (animal.Grounded)
                {
                    IsBottomEntry = MLadder.NearBottomEntry(transform);
                    Debugging($"Ladder Enter from Ground: {(IsBottomEntry ? "Bottom" : "Top")} Entry", "green");

                    animal.StartCoroutine(MTools.AlignTransform_Position(transform, IsBottomEntry ? MLadder.BottomEnterPos : MLadder.TopEnterPos, alignTime));
                    // animal.StartCoroutine(MTools.AlignTransform_Rotation(transform, isBottomEntry ? ladder.BottomRot : ladder.TopRot, alignTime));

                    //set the correct ID Status for the Stair
                    SetEnterStatus(IsBottomEntry ? BottomEnter : TopEnter);
                }
                else
                {
                    Debugging($"Ladder Enter from Air", "green");
                    SetEnterStatus(0);
                }
                base.Activate();
                animal.UseCameraInput = false;              //Climb cannot use Camera Input
                animal.Grounded = false;                //Climb cannot use Camera Input

                animal.SetPlatform(MLadder.Transform);

                EnableHitTransform(false);

                Exiting = false;
            }
            else
            {
                Debugging("There's no Ladder to Climb", "Red");
            }
        }

        public override void ResetState()
        {
            base.ResetState();
            // MLadder = null;
            CurrentStep = 0;
        }
        public override Vector3 Speed_Direction()
        {
            var Up = MLadder ? MLadder.Transform.up : this.Up;

            MDebug.DrawRay(Position, Up, Color.yellow);

            return Up * (animal.VerticalSmooth); //IMPORTANT! Override the Direction of the Controller
        }



        public override void OnStateMove(float deltatime)
        {
            //Remove Horizontal Side movement (This is used for quick Ladder Setups)
            animal.MovementAxis.x = 0;
            animal.MovementAxisRaw.x = 0;

            if (MainTagHash == ExitTagHash) return; //Do not execute anything if the state is exiting

            if (MLadder != null)
            {
                //Check if the Animal going UP and there's ceiling blocking the Ladder
                if (CheckCeiling && animal.MovementAxisSmoothed.z > 0)
                {
                    var CeilingPos = animal.transform.position + (animal.ScaleFactor * animal.Height * animal.transform.up);

                    if (Physics.Raycast(CeilingPos, Up, CeilingRay, CeilingLayer, collide))
                    {
                        animal.AdditivePosition = Vector3.zero; //Remove all movement;
                        animal.MovementAxis.z = 0; //Remove the Forward Climinb Up Movement
                    }
                }


                animal.SlopeNormal = MLadder.transform.up; //Set the Slope Normal to the Ladder Normal

                //remove the RootMotion and add it back
                // animal.AdditivePosition = Anim.deltaPosition * animal.CurrentSpeedSet.RootMotionPos; //Add the Delta Position to the Additive Position

                AlignTo_LadderCenter(MLadder, deltatime); //Align the character to the center q
                OrientToWall(deltatime); //Orient the character to the wall

                //Start aligning when coming from the Bottom of 1 second later if coming from the top or is entrying from Fall
                //  if (IsBottomEntry || animal.LastState.ID > 1 || MTools.ElapsedTime(CurrentEnterTime, TopAlignTime))
                {

                    var LadderClosestPoint = MLadder.Collider.ClosestPoint(transform.position);
                    var distance = Vector3.Distance(transform.position, LadderClosestPoint);
                    AlignToWall(distance, deltatime); //Align the character to the wall
                    MDebug.DrawWireSphere(LadderClosestPoint, Quaternion.identity, Color.red, 0.01f);
                    MDebug.DrawWireSphere(transform.position, transform.rotation, Color.red, 0.01f);
                }


                RepositionCharacterOnIdle(deltatime);
            }
        }

        private bool Exiting;

        public override void TryExitState(float DeltaTime)
        {
            if (Exiting) return;

            if (MLadder)
            {
                int CurrentStep = MLadder.NearStep(transform);

                //Moving Down
                if (MovementRaw.z < 0 && CurrentStep <= BottomExitStep) //Means the animal is going down
                {
                    SetExitStatus(BottomExit);
                    MLadder = null;
                    Debugging("[Allow Exit] Exit Bottom Ladder");
                    Exiting = true;
                }
                //Moving Up
                else if (MovementRaw.z > 0 && CurrentStep >= MLadder.Steps - TopExitStep) //Means the animal is going up
                {
                    SetExitStatus(TopExit);
                    MLadder = null;
                    Debugging("[Allow Exit] Exit Top Ladder");
                    Exiting = true;
                }
                else if (!MLadder.gameObject.activeInHierarchy)
                {
                    Debugging("[Allow Exit] Ladder is Disabled ");
                    AllowExit(StateEnum.Fall, 0); //If there's no Ladder then Exit
                    Exiting = true;
                }
            }
            else
            {
                Debugging("[Allow Exit] Ladder is Missing ");
                AllowExit(StateEnum.Fall, 0); //If there's no Ladder then Exit
                Exiting = true;
            }
        }

        private void RepositionCharacterOnIdle(float deltatime)
        {
            if (CurrentAnimTag == MainTagHash && RepositionOnIdle)
            {
                var closestStep = MLadder.NearStep(transform, true);

                var LadderCloseStepPosition = MLadder.GetStepPosition(closestStep);

                MDebug.DrawWireSphere(MLadder.GetStepPosition(CurrentStep), Quaternion.identity, 0.02f, Color.green);
                var PlayerCenter = MTools.ClosestPointOnPlane(transform.position, transform.forward, LadderCloseStepPosition);
                MDebug.DrawWireSphere(PlayerCenter, Quaternion.identity, 0.02f, Color.green);

                Vector3 alignTarget = AlignSmoothness * deltatime * (PlayerCenter - Position + (MLadder.transform.up * RepositionOffset));
                animal.Position += alignTarget;
            }
        }

        private void AlignToWall(float distance, float deltatime)
        {
            float difference = distance - LadderDistance * animal.ScaleFactor;

            if (!Mathf.Approximately(distance, LadderDistance * animal.ScaleFactor))
            {
                Vector3 align = AlignSmoothness * deltatime * difference * ScaleFactor * animal.Forward;
                animal.Position += align;
            }
        }

        private void OrientToWall(float deltatime)
        {
            Rotation = Quaternion.Lerp(transform.rotation, MLadder.transform.rotation, deltatime * AlignSmoothness);
        }

        private void AlignTo_LadderCenter(MLadder ladder, float deltatime)
        {
            if (!ladder) return;

            var WallCenter = MTools.ClosestPointOnLine(Position, ladder.transform.position, ladder.TopPos);
            var PlayerCenter = MTools.ClosestPointOnPlane(Position, transform.forward, WallCenter);

            Vector3 alignTarget = AlignSmoothness * deltatime * (PlayerCenter - Position);
            animal.AdditivePosition += alignTarget;

            MDebug.DrawWireSphere(WallCenter, Color.red, 0.05f);
            MDebug.DrawWireSphere(PlayerCenter, Color.green, 0.05f);
        }

        ///FIND LADDER ON INTERACTABLES OR IN ZONES 
        public void OnInteractableEnter(GameObject go, int ID)
        {
            if (IsActiveState) return; //Means the Ladder is already active

            MLadder = go.FindComponent<MLadder>();

            if (MLadder == null) return;
            m_HitTransform.position = MTools.ClosestPointOnLine((animal.Center + transform.up * Height), MLadder.TopPos, MLadder.BottomPos);

            bool CorrectPos = !MLadder.NearBottomEntry(transform) && animal.Grounded || Vector3.Angle(MLadder.transform.forward, animal.Forward) < 90;

            EnableHitTransform(CorrectPos);

            //If the Ladder is Auto then Activate the Ladder
            if (MLadder != null && MLadder.Interactable != null && MLadder.Interactable.Auto)
            {
                if (Vector3.Angle(MLadder.transform.forward, animal.Forward) < 90) //Check if the Ladder is in front of the Animal
                {
                    Activate();
                }
            }
        }

        /// <summary> On Interactable lost  </summary>
        public void OnInteractableExit(GameObject go, int ID)
        {
            //Debug.Log($"OnInteractableExit: {go}");

            //Meaning we are exiting Interactable and this is not the Active State
            if (MLadder != null && go == MLadder.gameObject && !IsActiveState)
            {
                MLadder = null; //Remove the Ladder
                EnableHitTransform(false);
            }
        }

        public override void ResetStateValues()
        {
            MLadder = null;
            animal.ResetCameraInput();
            ExitInputValue = false;
        }


        public override void StateGizmos(MAnimal animal)
        {
            var CeilingPos = animal.transform.position + (animal.ScaleFactor * animal.Height * animal.transform.up);

            if (CheckCeiling)
            {
                Gizmos.color = Color.yellow;
                MDebug.GizmoRay(CeilingPos, animal.transform.up * CeilingRay, 2);
                Gizmos.DrawSphere(CeilingPos + animal.transform.up * CeilingRay, 0.02f * animal.ScaleFactor);
            }
        }



#if UNITY_EDITOR
        internal override void Reset()
        {
            this.Reset();

            General = new AnimalModifier()
            {
                RootMotion = true,
                Grounded = false,
                Sprint = false,
                OrientToGround = false,
                CustomRotation = true,
                FreeMovement = false,
                AdditivePosition = true,
                AdditiveRotation = true,
                Gravity = false,
                modify = (modifier)(-1),
            };


            SpeedSets = new List<MSpeedSet>
            {
                new()
                {
                    name = "Ladder",
                    StartVerticalIndex = new(1),
                    TopIndex = new(2),
                    states = new List<StateID>(1) { ID },
                    Speeds =
                        new List<MSpeed>()
                        {
                            new MSpeed("Ladder")  { lerpPosAnim = new(30)  },
                            new MSpeed("Ladder Fast") {lerpPosAnim = new(30), animator = new FloatReference(1.33f) } }
                }
            };
        }
    }
#endif
}