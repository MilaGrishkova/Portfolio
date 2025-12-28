using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Enemy : MonoBehaviour
{
    public Transform targetObj;

    private void Update()
    {
        transform.position = Vector3.MoveTowards(this.transform.position, targetObj.position, 10* Time.deltaTime);
    }
  
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Player" )
        {
            collision.gameObject.GetComponent<Player>().RecountHeart(-1); 
        }
    }
}