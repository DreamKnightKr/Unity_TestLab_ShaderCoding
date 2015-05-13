using UnityEngine;
using System.Collections;

public class ProceduralTexture : MonoBehaviour {

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
				// get distance from Center.
				float pixelDistance = Vector2.Distance (currentPosition, centerPixelPosition) / (widthHeight * 0.5f);

				pixelDistance = Mathf.Abs (1 - Mathf.Clamp (pixelDistance, 0f, 1f));	// Clamp over 0.

				// Get Color Base-on Distance.
				Color pixelColor = new Color(pixelDistance, pixelDistance, pixelDistance, 1f);
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
