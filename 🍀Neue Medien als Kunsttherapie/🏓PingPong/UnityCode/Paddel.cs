using UnityEngine;

public class Paddel : MonoBehaviour
{
    public Rigidbody2D rgbd2d;
    public int id;
    public float moveSpeed = 2f;
     public GameObject LoseEffect;

    private Vector3 startPosition;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    private void Start()
    {
        startPosition = transform.position;
        GameManager.instance.onReset += ResetPosition;
          Instantiate(LoseEffect, transform.position, Quaternion.identity);
    }

    private void ResetPosition()
    {
        transform.position = startPosition;
    }


    // Update is called once per frame
    void Update()
    {
       float movement = ProcessInput();
        Move(movement);
    }

    private float ProcessInput()
    {
        float movement = 0f;
        switch (id)
        {
            case 1:
            movement = Input.GetAxis("MovePlayer1");
            break;

            case 2:
            movement = Input.GetAxis("MovePlayer2");
            break;

        }
        return movement;
    }

    private void Move(float movement)
    {
        Vector2 velo = rgbd2d.linearVelocity;
        velo.y = moveSpeed * movement;
        rgbd2d.linearVelocity = velo;
    }
}
