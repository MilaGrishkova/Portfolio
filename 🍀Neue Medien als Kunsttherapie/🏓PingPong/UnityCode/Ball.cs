using UnityEngine;

public class Ball : MonoBehaviour
{
    public Rigidbody2D rgbd2d;
    public float maxInitialAngel = 0.67f;
    public float moveSpeed = 1f;
    public float maxStartY = 4f;
    public float speedMultiplier = 1.1f;
   
    private float startX = 0f;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        InitialPush();
        GameManager.instance.onReset += ResetBall;       
    }

    private void ResetBall()
    {
        ResetBallPosition();
        InitialPush();
    }

    private void InitialPush()
    {
        Vector2 dir = Random.value < 0.5f? Vector2.left: Vector2.right;
        dir.y = Random.Range(-maxInitialAngel, maxInitialAngel);
        rgbd2d.linearVelocity = dir * moveSpeed;
    }

    private void ResetBallPosition()
    {
        float posY = Random.Range(-maxStartY, maxStartY);
        Vector2 position = new Vector2(startX, posY);
        transform.position = position;
        Instantiate(LoseEffect, transform.position, Quaternion.identity);
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        ScoreZone scoreZone = collision.GetComponent<ScoreZone>();
        if(scoreZone)
        {
            GameManager.instance.OnScoreZoneReached(scoreZone.id);
            Debug.Log("iLoveY");
            Instantiate(LoseEffect);
        }
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        Paddel paddel = collision.collider.GetComponent<Paddel>();
        if(paddel)
        {
            rgbd2d.linearVelocity *= speedMultiplier;
        }
    }
}
