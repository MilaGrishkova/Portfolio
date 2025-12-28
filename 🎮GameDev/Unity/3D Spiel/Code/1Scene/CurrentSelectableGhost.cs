using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CurrentSelectableGhost : MonoBehaviour
{
    public AudioCollection audioCollect;
    private AudioSource audioSource;
    // Start is called before the first frame update
    public void Select()
    {
        GetComponent<AudioSource>();
        audioCollect.PlayFlySound();
    }

    // Update is called once per frame
    public void Deselect()
    {
        GetComponent<Renderer>().material.color = Color.grey;
    }
}
