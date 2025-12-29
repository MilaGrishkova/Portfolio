using System.Collections;
using System.Collections.Generic;
using UnityEngine;



public class Controller : MonoBehaviour
{
    public GameObject Sphere1;
    public GameObject Sphere2;
    public GameObject ARCamera;
    public GameObject Target;
    public Soundeffector soundeffector;
    public AudioSource myAudioSource;


    void Start()
    {
        Sphere2.gameObject.SetActive(false);
        myAudioSource = GetComponent<AudioSource>();
    }

    void Update()
    {
        if(Input.GetKey(KeyCode.Space))
        {
           Sphere2.gameObject.SetActive(true);
           Target.GetComponent<AudioSource>().Play();
           Sphere2.transform.position = Vector3.zero;
           Destroy(Sphere1);
           soundeffector.PlayBoomSound();
           Invoke("AudioSourceDestr", 10f);
        }
    }

    void AudioSourceDestr()
    {
        Destroy(myAudioSource);
    }

}
