using System.Collections;
using System.Collections.Generic;
using Eccentric;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Main : MonoBehaviour
{
    public Image[] hearts;
    public Player player;
    public CameraMove cameraMove;
    public Sprite isLife, nonLife;
    public GameObject PauseScreen;
    public string sceneNameToLoad;

    void Update()
    {
        for (int i = 0; i < hearts.Length; i++)
        {
            if (player.GetHeart() > i)
                hearts[i].sprite = isLife;
            else
                hearts[i].sprite = nonLife;
        }
    }

    public void PauseOn()
    {
        Time.timeScale = 0f;
        player.enabled = false;
        cameraMove.enabled = false;
        PauseScreen.SetActive(true);
    }

    public void PauseOff()
    {
        Time.timeScale = 1f;
        player.enabled = true;
        PauseScreen.SetActive(false);
        cameraMove.enabled = true;
    }

    public void Win()
    {
        SceneManager.LoadScene(sceneNameToLoad);
    }
}