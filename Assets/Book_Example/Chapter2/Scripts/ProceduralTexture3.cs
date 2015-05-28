using UnityEngine;
using System.Collections;

public class ProceduralTexture3 : MonoBehaviour {

	public int widthHeight = 512;
	public Texture2D generatedTexture;

	private Material currentMaterial;
	private Vector2 centerPosition;

	// Use this for initialization
	void Start () {

		if (!currentMaterial) {
			currentMaterial = transform.GetComponent<Renderer>().sharedMaterial;
			if(!currentMaterial)
			{
				Debug.LogWarning ("Cannot find a matrial on : " + transform.name);
			}
		}

		// Create Procedural Teature
		if (currentMaterial) {
			centerPosition = new Vector2(0.5f, 0.5f);
			generatedTexture = GenerateParabola();

			// Set Texture To Material
			currentMaterial.SetTexture ("_MainTex", generatedTexture);
		}
	
	}

	Texture2D GenerateParabola ()
	{
		Texture2D proceduralTexture = new Texture2D (widthHeight, widthHeight);
		Vector2 centerPixelPosition = centerPosition * widthHeight;	// get Center Coordinate.

		for (int x = 0; x < widthHeight; x++) {
			for(int y = 0; y < widthHeight; y++)
			{
				Vector2 currentPosition = new Vector2(x, y);
				//you can also do some more advanced vector calculations to achieve
				//other types of data about the model itself and its uvs and
				//pixels
				Vector2 pixelDirection = centerPixelPosition - currentPosition;
				pixelDirection.Normalize();
				float rightDirection = Vector2.Angle(pixelDirection, Vector3.right)/360;
				float leftDirection = Vector2.Angle(pixelDirection, Vector3.left)/360;
				float upDirection = Vector2.Angle(pixelDirection, Vector3.up)/360;

				// Get Color Base-on Distance.
				Color pixelColor = new Color(rightDirection, leftDirection, upDirection, 1.0f);
				proceduralTexture.SetPixel (x, y, pixelColor);
			}
		}

		proceduralTexture.Apply ();

		return proceduralTexture;

	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
