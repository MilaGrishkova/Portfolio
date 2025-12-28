using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Player : MonoBehaviour
{
    int maxHeart = 3;
    int curHeart;
    public AudioCollection audioCollection;
    public RandomSound randomSound;
    public Main main;
    // Start is called before the first frame update
    void Start()
    {
        curHeart = maxHeart;
    }

    public void RecountHeart(int deltaHeart)
    {
        curHeart = curHeart + deltaHeart;

        if (deltaHeart < 0)
        {
            audioCollection.PlayHeart();
            randomSound.PlaySound();
        }

        print(curHeart);
        if (curHeart <= 0)
        {
            SceneManager.LoadScene("0");
            GetComponent<CapsuleCollider>().enabled = false;
        }
    }

    private void OnTriggerEnter(Collider collision)
    {
      if (collision.gameObject.tag == "Heart")
        {
            Destroy(collision.gameObject);
            audioCollection.PlayHeart();
            RecountHeart(1);
        }
    }

    public int GetHeart()
    {
        return curHeart;
    }
}