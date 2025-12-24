using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioCollection : MonoBehaviour
{
    public AudioSource audioSource;
    public AudioClip bullet, coin1Sound, coinSound, doorSound, enemyDead, ground1, ground2, ground3, ground4, ground5, groundD, groundD2, heartSound, hiHatSound, inWater, intro, intro2, jumpSound, keySound, kickSound, killSound, loseSound, markBox, painSound, saw, shakerSound, snareSound, starSound, stepSound, tonSound, trampoline, water, winSound;
    
public void PlayBulletSound()
{
    audioSource.PlayOneShot(bullet);
}

public void PlayCoin1Sound()
{
    audioSource.PlayOneShot(coin1Sound);
}

public void PlayCoinSound()
{
    audioSource.PlayOneShot(coinSound);
}

public void PlayDoorSound()
{
    audioSource.PlayOneShot(doorSound);
}

public void PlayEnemyDeadSound()
{
    audioSource.PlayOneShot(enemyDead);
}

public void PlayGround1()
{
    audioSource.PlayOneShot(ground1);
}

public void PlayGround2()
{
    audioSource.PlayOneShot(ground2);
}

public void PlayGround3()
{
    audioSource.PlayOneShot(ground3);
}

public void PlayGround4()
{
    audioSource.PlayOneShot(ground4);
}

public void PlayGround5()
{
    audioSource.PlayOneShot(ground5);
}

public void PlayGroundD()
{
    audioSource.PlayOneShot(groundD);
}

public void PlayGroundD2()
{
    audioSource.PlayOneShot(groundD2);
}

public void PlayHeartSound()
{
    audioSource.PlayOneShot(heartSound);
}

public void PlayHiHatSound()
{
    audioSource.PlayOneShot(hiHatSound);
}

public void PlayInWater()
{
    audioSource.PlayOneShot(inWater);
}

public void PlayIntro()
{
    audioSource.PlayOneShot(intro);
}

public void PlayIntro2()
{
    audioSource.PlayOneShot(intro2);
}

public void PlayJumpSound()
{
    audioSource.PlayOneShot(jumpSound);
}

public void PlayKeySound()
{
    audioSource.PlayOneShot(keySound);
}

public void PlayKickSound()
{
    audioSource.PlayOneShot(kickSound);
}

public void PlayKillSound()
{
    audioSource.PlayOneShot(killSound);
}

public void PlayLoseSound()
{
    audioSource.PlayOneShot(loseSound);
}

public void PlayMarkBox()
{
    audioSource.PlayOneShot(markBox);
}

public void PlayPainSound()
{
    audioSource.PlayOneShot(painSound);
}

public void PlaySaw()
{
    audioSource.PlayOneShot(saw);
}

public void PlayShakerSound()
{
    audioSource.PlayOneShot(shakerSound);
}

public void PlaySnareSound()
{
    audioSource.PlayOneShot(snareSound);
}

public void PlayStar()
{
    audioSource.PlayOneShot(starSound);
}

public void PlayStepSound()
{
    audioSource.PlayOneShot(stepSound);
}

public void PlayTonSound()
{
    audioSource.PlayOneShot(tonSound);
}

public void PlayTrampoline()
{
    audioSource.PlayOneShot(trampoline);
}

public void PlayWaterSound()
{
    audioSource.PlayOneShot(water);
}

public void PlayWinSound()
{
    audioSource.loop = true;
    audioSource.PlayOneShot(winSound);
}
