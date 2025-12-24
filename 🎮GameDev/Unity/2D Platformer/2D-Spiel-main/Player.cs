using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    public GameObject BulletEffect;
    public GameObject CoinEffect;
    public GameObject DestroyedEffect;
    public GameObject EnemyEffect;
    public GameObject GroundEffect;
    public GameObject GreenDiamondEffect;
    public GameObject HeartEffect;
    public GameObject KeyEffect;
    public GameObject KeyEffect2;
    public GameObject LadderEffect;
    public GameObject LoopEffect;
    public GameObject LoseEffect;
    public GameObject LoseEffect2;
    public GameObject LoseEffect3;
    public GameObject MushroomEffect;
    public GameObject PlayerEffect;
    public GameObject StarEffect;
    public GameObject TrampolineEffect;
    [HideInInspector] public bool isFacingRight = true;
    bool canHit = true;
    bool canTeleport = true;
    bool isClimbing = false;
    bool isGrounded;
    bool isHit = false;
    int box = 0;
    public GameObject BoxNew;
    int coins = 0;
    int curHeart;
    private float Fast;
    public GameObject greenDiamond;
    public GameObject GroundNew;
    private AudioSource LoopAudio;
    private float Long;
    public Main main;
    int maxHeart = 3;
    public bool inWater = false;
    public bool key = false;
    public bool key2 = false;
    public Animator anim;
    private float Power;
    Rigidbody2D rigidbody;
    public float speed;
    int star = 0;
    private Vector2 targetPos;
    public Transform floorCheck;
    public float jumpHeight;
    public AudioCollection audioCollect;
    public GameObject SawNew;


    void Start()
    {
        rigidbody = GetComponent<Rigidbody2D>();
        anim = GetComponent<Animator>();
        curHeart = maxHeart;
        GroundNew.SetActive(false);
        SawNew.SetActive(false);
    }

    void Update()
    {
        if (inWater && !isClimbing)
        {
            anim.SetInteger("State", 4);
            isGrounded = true;
            if (Input.GetAxis("Horizontal") != 0)
                Flip();
        }
        else
        {
            CheckGround();
            if (Input.GetAxis("Horizontal") == 0 && (isGrounded) && !isClimbing)
            {
                anim.SetInteger("State", 1);
            }
            else
            {
                Flip();
                if (isGrounded && !isClimbing)
                    anim.SetInteger("State", 2);
            }
        }

        if (Input.GetKeyDown(KeyCode.UpArrow))
        {
            audioCollect.PlayShakerSound();
        }

        if (Input.GetKeyDown(KeyCode.DownArrow))
        {
            audioCollect.PlayBulletSound();
        }

        if (Input.GetKeyDown(KeyCode.Space))
        {
            audioCollect.PlayJumpSound();
        }

        if (Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            rigidbody.AddForce(transform.up * jumpHeight, ForceMode2D.Impulse);
            Instantiate(PlayerEffect, transform.position, Quaternion.identity);
        }
    }

    private void LateUpdate()
    {
        if (Long > 0)
        {
            Long -= Time.deltaTime;

            float xAmount = Random.Range(-1f, 1f) * Power;
            float yAmount = Random.Range(-1f, 1f) * Power;

            transform.position +=
               new Vector3(xAmount, yAmount, 0f);
            Power = Mathf.MoveTowards(Power, 0f, Fast * Time.deltaTime);
        }
    }

    public void StartShake(float length, float power)
    
    {
        Long = length;
        Power = power;
        Fast = power / length;
    }

    void FixedUpdate()
    {
        rigidbody.velocity =
        new Vector2(Input.GetAxis("Horizontal") * speed, rigidbody.velocity.y);
    }

    void Flip()
    {
        if (Input.GetAxis("Horizontal") > 0)
        {
            transform.localRotation = Quaternion.Euler(0, 0, 0);
            isFacingRight = true;
        }
        if (Input.GetAxis("Horizontal") < 0)
        {
            transform.localRotation = Quaternion.Euler(0, 180, 0);
            isFacingRight = false;
        }
    }

    void CheckGround()
    {
        Collider2D[] colliders = Physics2D.OverlapCircleAll(floorCheck.position, 0.2f);
        isGrounded = (colliders.Length > 1) && (colliders[1].gameObject.tag != "Trampoline") && (colliders[0].gameObject.tag != "Trampoline");

        if (!isGrounded && !isClimbing)
            anim.SetInteger("State", 3);
    }

    public void RecountHeart(int deltaHeart)
    {
        curHeart = curHeart + deltaHeart;
        if (deltaHeart < 0)
        {
            StopCoroutine(OnHit()); 
            isHit = true;
            audioCollect.PlayPainSound();
            StartCoroutine(OnHit());
            Instantiate(EnemyEffect, transform.position, Quaternion.identity);
            StartShake(0.3f, 0.3f);
        }

        print(curHeart);
        if (curHeart <= 0) 
        {
            GetComponent<CapsuleCollider2D>().enabled = false;
            Invoke("Lose", 1.5f);
            StartShake(0.3f, 0.3f);
            Instantiate(LoseEffect, transform.position, Quaternion.identity);
            Instantiate(LoseEffect2, transform.position, Quaternion.identity);
            Instantiate(LoseEffect3, transform.position, Quaternion.identity);
            LoopAudio.Stop();
        }
    }

    IEnumerator OnHit()
    {
        if (isHit)
            GetComponent<SpriteRenderer>().color = new Color(1f, GetComponent<SpriteRenderer>().color.g - 0.04f, GetComponent<SpriteRenderer>().color.b - 0.04f);
        else
            GetComponent<SpriteRenderer>().color = new Color(1f, GetComponent<SpriteRenderer>().color.g + 0.04f, GetComponent<SpriteRenderer>().color.b + 0.04f);

        if (GetComponent<SpriteRenderer>().color.g == 1f)
        {
            StopCoroutine(OnHit());
            canHit = true;
            StartShake(0.3f, 0.3f);
        }
        if (GetComponent<SpriteRenderer>().color.g <= 0)
            isHit = false;
        yield return new WaitForSeconds(0.02f);
        StartCoroutine(OnHit());
    }

    void Lose()
    {
        main.GetComponent<Main>().Lose();
        audioCollect.PlayLoseSound();
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.gameObject.tag == "Loop")
        {
            Instantiate(LoopEffect, transform.position, Quaternion.identity);
            StartCoroutine(PlayLoopAudio());
            Destroy(collision.gameObject);
        }

        if (collision.gameObject.tag == "HiHat")
        {
            box++;
            Instantiate(DestroyedEffect, transform.position, Quaternion.identity);
            audioCollect.PlayHiHatSound();
        }

        if (collision.gameObject.tag == "Kick")
        {
            box++;
            Instantiate(DestroyedEffect, transform.position, Quaternion.identity);
            audioCollect.PlayKickSound();
        }

        if (collision.gameObject.tag == "Snare")
        {
            box++;
            Instantiate(DestroyedEffect, transform.position, Quaternion.identity);
            audioCollect.PlaySnareSound();
        }

        if (collision.gameObject.tag == "Destroyed")
        {
            Instantiate(DestroyedEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Bullet")
        {
            Instantiate(BulletEffect, transform.position, Quaternion.identity);
            audioCollect.PlayBulletSound();
        }

        if (collision.gameObject.tag == "Key")
        {
            audioCollect.PlayKeySound();
            Destroy(collision.gameObject);
            key = true;
            Instantiate(KeyEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Door")
        {
            if (collision.gameObject.GetComponent<Door>().isOpen && canTeleport)
            {
                collision.gameObject.GetComponent<Door>().Teleport(gameObject);
                canTeleport = false;
                StartCoroutine(TPwait());
                audioCollect.PlayDoorSound();
            }

            else if (key)
                collision.gameObject.GetComponent<Door>().Open();
        }

        if (collision.gameObject.tag == "Key2")
        {
            audioCollect.PlayKeySound();
            Destroy(collision.gameObject);
            key2 = true;
            Instantiate(KeyEffect2, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Door2")
        {
            if (collision.gameObject.GetComponent<Door>().isOpen && canTeleport)
            {
                collision.gameObject.GetComponent<Door>().Teleport(gameObject);
                canTeleport = false;
                StartCoroutine(TPwait());
                audioCollect.PlayDoorSound();
            }
            else if (key2)
                collision.gameObject.GetComponent<Door>().Open();
        }

        if (collision.gameObject.tag == "Coin1")
        {
            Destroy(collision.gameObject);
            coins++;
            audioCollect.PlayCoinSound();
            Instantiate(CoinEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Turururu")
        {
            Destroy(collision.gameObject);
            box++;
            audioCollect.PlayTurururuSound();
            Instantiate(CoinEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Heart")
        {
            Destroy(collision.gameObject);
            audioCollect.PlayHeartSound();
            RecountHeart(1);
            Instantiate(HeartEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Star")
        {
            Destroy(collision.gameObject);
            star++;
            audioCollect.PlayStar();
            Instantiate(StarEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Intro")
        {
            audioCollect.PlayIntro();
        }

        if (collision.gameObject.tag == "Intro2")
        {
            audioCollect.PlayIntro2();
        }

        if (collision.gameObject.tag == "Ground1")
        {
            box++;
            audioCollect.PlayGround1();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Ground2")
        {
            box++;
            audioCollect.PlayGround2();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Ground3")
        {
            box++;
            audioCollect.PlayGround3();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Ground4")
        {
            box++;
            audioCollect.PlayGround4();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Ground5")
        {
            box++;
            audioCollect.PlayGround5();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
            Destroy(GameObject.FindWithTag("Ground5"));
            GroundNew.SetActive(true);
        }

        if (collision.gameObject.tag == "Ground6")
        {
            box++;
            audioCollect.PlayGround5();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
            Destroy(GameObject.FindWithTag("Ground6"));
            SawNew.SetActive(true);
        }

        if (collision.gameObject.tag == "Ground7")
        {
            box++;
            audioCollect.PlayGround3();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
            Destroy(GameObject.FindWithTag("Ground7"));
            BoxNew.SetActive(true);
        }

        if (collision.gameObject.tag == "Saw")
        {
            audioCollect.PlaySaw();
        }

        if (collision.gameObject.tag == "GreenDiamond")
        {
            Destroy(collision.gameObject);
            StartCoroutine(SpeedGreenDiamond());
            Instantiate(GreenDiamondEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "GroundD")
        {
            box++;
            Destroy(collision.gameObject);
            audioCollect.PlayGroundD();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "GroundD2")
        {
            box++;
            Destroy(collision.gameObject);
            audioCollect.PlayGroundD2();
            Instantiate(GroundEffect, transform.position, Quaternion.identity);
        }

        if (collision.gameObject.tag == "Water")
        {
            audioCollect.PlayWaterSound();
        }
    }

    IEnumerator SpeedGreenDiamond()
    {
        greenDiamond.SetActive(true);
        greenDiamond.transform.localPosition = new Vector3(0f, 0.7f, greenDiamond.transform.localPosition.z);
        speed = speed * 2;
        rigidbody.AddForce(transform.up * jumpHeight * 1.2f, ForceMode2D.Impulse);
        yield return new WaitForSeconds(9f);
        speed = speed / 2;
        greenDiamond.SetActive(false);
        rigidbody.AddForce(transform.up * jumpHeight / 1.2f, ForceMode2D.Impulse);
    }

    IEnumerator PlayLoopAudio()
    {
        LoopAudio = GetComponent<AudioSource>();
        float length = LoopAudio.clip.length;

        while (true)
        {
            LoopAudio.Play();
            yield return new WaitForSeconds(length);
        }
    }

    IEnumerator TPwait()
    {
        yield return new WaitForSeconds(1f);
        canTeleport = true;
    }

    private void OnTriggerStay2D(Collider2D collision)
    {
        if (collision.gameObject.tag == "Ladder")
        {
            isClimbing = true;
            rigidbody.bodyType = RigidbodyType2D.Kinematic;
            if (Input.GetAxis("Vertical") == 0)
            {
                anim.SetInteger("State", 5);
            }
            else
            {
                anim.SetInteger("State", 6);
                transform.Translate(Vector3.up * Input.GetAxis("Vertical") * speed * 0.5f * Time.deltaTime);
                Instantiate(LadderEffect, transform.position, Quaternion.identity);
            }
        }
    }

    private void OnTriggerExit2D(Collider2D collision)
    {
        if (collision.gameObject.tag == "Ladder")
        {
            isClimbing = false;
            rigidbody.bodyType = RigidbodyType2D.Dynamic;
        }
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.tag == "Trampoline")
        {
            StartCoroutine(TrampolineAnim(collision.gameObject.GetComponentInParent<Animator>()));
            audioCollect.PlayTrampoline();
            Instantiate(TrampolineEffect, transform.position, Quaternion.identity);
        }
    }

    IEnumerator TrampolineAnim(Animator an)
    {
        yield return new WaitForSeconds(0.5f);
        an.SetBool("isJump", false);
    }

    public int GetCoins()
    {
        return coins;
    } 

    public int GetBox()
    {
        return box;
    }

    public int GetStar()
    {
        return star;
    }

    public int GetHeart()
    {
        return curHeart;
    }
}
