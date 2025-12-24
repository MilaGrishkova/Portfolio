using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shooting : MonoBehaviour
{
    public float feuerRate = 0.2f;
    public GameObject bulletPlayerPrefab;
    public Transform FeuerPoint;
    float TimeFeuer;
    Player pm;

    void Start()
    {
        pm = gameObject.GetComponent<Player>();
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.DownArrow) && TimeFeuer < Time.time)
        {
            Shoot();
            TimeFeuer = Time.time + feuerRate;
        }
    }

    void Shoot()
    {
        float angle = pm.isFacingRight ? 0f : 180f;
        Instantiate(bulletPlayerPrefab, FeuerPoint.position, Quaternion.Euler(new Vector3(0f, 0f, angle)));
    }
}