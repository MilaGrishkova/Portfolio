using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Soundeffector : MonoBehaviour
{
    public AudioSource audioSource;
    public AudioClip boom;

    public void PlayBoomSound()
    {
        audioSource.PlayOneShot(boom);
    }
}
