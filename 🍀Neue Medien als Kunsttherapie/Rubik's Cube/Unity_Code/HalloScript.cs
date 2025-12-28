using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HalloScript : MonoBehaviour
{
    public GameObject HalloScreen;
    public Cube cubePlayer;

    void Start()
    {
      HalloScreen.SetActive(false);
    }

    public void HalloScreenOn()
    {
      cubePlayer.enabled = true;
      HalloScreen.SetActive(true);
      cubePlayer.GetComponent<Cube>().enabled = false;
    }

    public void HalloScreenOff()
    {
      cubePlayer.enabled = false;
      HalloScreen.SetActive(false);
      cubePlayer.GetComponent<Cube>().enabled = true;
    }
}
