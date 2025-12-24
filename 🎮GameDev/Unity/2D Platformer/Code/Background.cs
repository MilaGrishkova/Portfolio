using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Background : MonoBehaviour
{
    float length;
    public GameObject MainCamera;
    public float parallaxEffect;
    float positionStart;

    void Start()
    {
        positionStart = transform.position.x;
        length = GetComponent<SpriteRenderer>().bounds.size.x;
    }

    void FixedUpdate()
    {
       float tempo = MainCamera.transform.position.x * (1 -
       parallaxEffect);
       float distance = MainCamera.transform.position.x *
       parallaxEffect;
       
       transform.position = new Vector3(positionStart +
       distance, transform.position.y, transform.position.z);

       if (tempo > positionStart + length)
            positionStart += length;
       else if (tempo < positionStart - length)
            positionStart -= length;
    }
}