using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyFollow : MonoBehaviour
{
    public NavMeshAgent enemy;
    public Transform player;
    Animator anim;
   
    public void EnemyFollowU()
        {
            enemy.SetDestination(player.position);
        }
}