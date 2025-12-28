using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckGround : MonoBehaviour
{
    public float Distance;
    public LayerMask LayerMask;
    
    // Update is called once per frame
    void Update()
    {
        Ray ray = new Ray(transform.position, Vector3.up);
        Debug.DrawRay(ray.origin, ray.direction * Distance);

        if(Physics.Raycast(ray, Distance, LayerMask))
        {
            GetComponent<Renderer>().material.color = Color.red * 0.7f;
        }
        else
        {
            GetComponent<Renderer>().material.color = Color.grey;
        }
    }
}
