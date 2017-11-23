using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderTest : MonoBehaviour {

    public Material mat;

	// Use this for initialization
	void Start ()
    {
		
	}
	
	// Update is called once per frame
	void Update ()
    {
        mat.SetInt("Scale", (int)Mathf.PingPong(Time.time * 20, 100) + 30);
        mat.SetInt("NoiseIntensity", (int)Mathf.PingPong(Time.time * 20, 100) + 5);
	}



    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        // Copy the source Render Texture to the destination,
        // applying the material along the way.
        Graphics.Blit(src, dest, mat);
    }
}
