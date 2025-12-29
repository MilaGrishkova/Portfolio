using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Effect : MonoBehaviour
{
    public GameObject EffectBoom1;
    public GameObject EffectBoom2;
    public GameObject EffectBoom3;
    
    void Update()
    {
        if(Input.GetKey(KeyCode.Space))
        {
           Instantiate(EffectBoom1, Vector3.zero, Quaternion.identity);
           Instantiate(EffectBoom2, Vector3.zero, Quaternion.identity);
           Instantiate(EffectBoom3, Vector3.zero, Quaternion.identity);
        }
    }
}
