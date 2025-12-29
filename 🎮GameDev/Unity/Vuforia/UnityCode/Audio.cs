using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Audio : MonoBehaviour
{
    public AudioClip[] aClips;
    public AudioSource myAudioSource;

     void Start()
    {
        myAudioSource = GetComponent<AudioSource>();
    }

    void OnMouseOver()
    {
     if (Input.GetMouseButtonDown(0))
        {
            myAudioSource.clip = aClips[Random.Range(0, aClips.Length)];
            myAudioSource.PlayOneShot (myAudioSource.clip);
        }
    }
}
