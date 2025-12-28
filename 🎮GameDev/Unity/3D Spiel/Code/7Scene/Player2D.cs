using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player2D : MonoBehaviour
{
    public AudioCollection audioCollection;
    Rigidbody2D rigidbody;
    public float jumpHeight;
    bool isGrounded;
    public Transform floorCheck;
    // Start is called before the first frame update
    void Start()
    {
        rigidbody = GetComponent<Rigidbody2D>();
    }

    // Update is called once per frame
    void Update()
    {
        isGrounded = true;
        transform.Translate(Input.GetAxis("Horizontal") * Time.deltaTime * 90, 0, 0);

        if (Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            audioCollection.PlayJumpSound();
            rigidbody.AddForce(transform.up * jumpHeight, ForceMode2D.Impulse);
        }
    }

    void CheckGround()
    {
        Collider2D[] colliders = Physics2D.OverlapCircleAll(floorCheck.position, 0.2f);
    }
}