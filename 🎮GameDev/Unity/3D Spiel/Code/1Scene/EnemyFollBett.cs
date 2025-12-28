using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyFollBett : MonoBehaviour
{
    public NavMeshAgent enemy;
    public Transform player;
    Animator anim;
    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        enemy.SetDestination(player.position);
        anim.SetInteger("State", 2);
    }
}