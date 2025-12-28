using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Audio;

public class RandomSound : MonoBehaviour
{
    public AudioClip[] clips;
    public AudioMixerGroup output;
   
    void Start()
    {
        StartCoroutine(waiting());   
    }

    IEnumerator waiting()
    {
        while (true)
        {
            print("RandomSoundAtmo");    
            PlaySound();
            yield return new WaitForSeconds(20); 
        }
    }

    public void PlaySound()
    {
        int randomClip = UnityEngine.Random.Range(0, clips.Length);
        AudioSource source = gameObject.AddComponent<AudioSource>();
        source.clip = clips[randomClip];
        source.outputAudioMixerGroup = output;
        source.Play();
        Destroy(source, clips[randomClip].length);
    } 
}