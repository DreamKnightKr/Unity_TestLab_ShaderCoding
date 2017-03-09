using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CgShaderUsingDiscard : MonoBehaviour {

	public Transform target;

	// Use this for initialization
	void Update () {
		Matrix4x4 mat = target.worldToLocalMatrix;
		GetComponent<Renderer> ().sharedMaterial.SetMatrix("_matrixTemp", mat);
	}
}
