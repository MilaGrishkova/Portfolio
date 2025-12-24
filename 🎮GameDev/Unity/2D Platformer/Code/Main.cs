using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Main : MonoBehaviour
{
    private float Long, Power, Fast;
    public Player player;
    public Text coinText;
    public Text boxText;
    public Text starText;
    public Image[] hearts;
    public Sprite isLife, nonLife;
    public GameObject PauseScreen;
    public GameObject WinScreen;
    public GameObject LoseScreen;
    public AudioCollection audioCollect;
    public AudioSource musicSourse, soundSourse;
    private AudioSource[] allAudioSources;

    public void Reloadlvl()
    {
        Time.timeScale = 1f;
        player.enabled = true;
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

    private void Start()
    {
        musicSourse.volume = (float)PlayerPrefs.GetInt("MusicVolume") / 9;
        soundSourse.volume = (float)PlayerPrefs.GetInt("SoundVolume") / 9;
    }

    private void LateUpdate()
    {
        if (Long > 0)
        {
            Long -= Time.deltaTime;

            float xAmount = Random.Range(-1f, 1f) * Power;
            float yAmount = Random.Range(-1f, 1f) * Power;

            transform.position += new Vector3(xAmount, yAmount, 0f);
            Power = Mathf.MoveTowards(Power, 0f, Fast * Time.deltaTime);
        }
    }

    public void StartShake(float length, float power)
    {
        Long = length;
        Power = power;
        Fast = power / length;
    }

    public void Update()
    {
        coinText.text = player.GetCoins().ToString();
        boxText.text = player.GetBox().ToString();
        starText.text = player.GetStar().ToString();

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
        PauseScreen.SetActive(true);
    }

    public void PauseOff()
    {
        Time.timeScale = 1f;
        player.enabled = true;
        PauseScreen.SetActive(false);
    }

    public void Win()
    {
        Time.timeScale = 0f;
        player.enabled = false;
        WinScreen.SetActive(true);
        StartShake(0.3f, 0.3f);
        allAudioSources = FindObjectsOfType(typeof(AudioSource)) as AudioSource[];
        foreach (AudioSource audioS in allAudioSources)
        {
            audioS.Stop();
        }

        audioCollect.PlayWinSound();

        if (!PlayerPrefs.HasKey("Lvl") ||
       PlayerPrefs.GetInt("Lvl") <
        SceneManager.GetActiveScene().buildIndex)
            PlayerPrefs.SetInt("Lvl",
       SceneManager.GetActiveScene().buildIndex);

        if (PlayerPrefs.HasKey("coins"))
            PlayerPrefs.SetInt("coins",
        PlayerPrefs.GetInt("coins") + player.GetCoins());
        else
            PlayerPrefs.SetInt("coins", player.GetCoins());
        print(PlayerPrefs.GetInt("coins"));

        if (PlayerPrefs.HasKey("box"))
            PlayerPrefs.SetInt("box", PlayerPrefs.GetInt("box") + player.GetBox());
        else
            PlayerPrefs.SetInt("box", player.GetBox());
        print(PlayerPrefs.GetInt("box"));

        if (PlayerPrefs.HasKey("star"))
            PlayerPrefs.SetInt("star", PlayerPrefs.GetInt("star") + player.GetStar());
        else
            PlayerPrefs.SetInt("star", player.GetStar());
        print(PlayerPrefs.GetInt("star"));
    }

    public void Lose()
    {
        Time.timeScale = 0f;
        player.enabled = false;
        StartShake(0.3f, 0.3f);
        LoseScreen.SetActive(true);
    }

    public void MenuLvl()
    {
        Time.timeScale = 1f;
        player.enabled = true;
        SceneManager.LoadScene("Menu");
    }

    public void NextLvl()
    {
        Time.timeScale = 1f;
        player.enabled = true;
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    } 
}
