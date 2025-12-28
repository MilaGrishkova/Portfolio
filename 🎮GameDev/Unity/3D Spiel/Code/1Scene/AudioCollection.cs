using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioCollection : MonoBehaviour
{
    public AudioSource audioSource;
    public AudioClip fly, heart, jump, kill;

    public void PlayFlySound()
    {
        audioSource.PlayOneShot(fly);
    }

    public void PlayKillSound()
    {
        audioSource.PlayOneShot(kill);
    }

    public void PlayJumpSound()
    {
        audioSource.PlayOneShot(jump);
    }

    public void PlayHeart()
    {
        audioSource.PlayOneShot(heart);
    }
}
