using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cube : MonoBehaviour
{
    public AudioSource myAudioSource;
    public GameObject CubePiecePrefab;
    Transform CubeTransform;
    List<GameObject> AllCubePieces = new List<GameObject>();
    GameObject CubeCenterPiece;
    bool canRotate = true;
    public HalloScript scriptHallo;

    List<GameObject> UpPieces
    {//https://www.youtube.com/watch?v=IISStnxa9jM&t=373s
      get
      {
        return AllCubePieces.FindAll(x => Mathf.Round(x.transform.localPosition.y) == 0);
      }
    }

    List<GameObject> DownPieces
    {//https://www.youtube.com/watch?v=IISStnxa9jM&t=373s
      get
      {
        return AllCubePieces.FindAll(x => Mathf.Round(x.transform.localPosition.y) == -2);
      }
    }

    List<GameObject> FrontPieces
    {//https://www.youtube.com/watch?v=IISStnxa9jM&t=373s
      get
      {
        return AllCubePieces.FindAll(x => Mathf.Round(x.transform.localPosition.x) == 0);
      }
    }

    List<GameObject> BackPieces
    {//https://www.youtube.com/watch?v=IISStnxa9jM&t=373s
      get
      {
        return AllCubePieces.FindAll(x => Mathf.Round(x.transform.localPosition.x) == -2);
      }
    }

    List<GameObject> LeftPieces
    {//https://www.youtube.com/watch?v=IISStnxa9jM&t=373s
      get
      {
        return AllCubePieces.FindAll(x => Mathf.Round(x.transform.localPosition.z) == 0);
      }
    }

    List<GameObject> RightPieces
    {//https://www.youtube.com/watch?v=IISStnxa9jM&t=373s
      get
      {
        return AllCubePieces.FindAll(x => Mathf.Round(x.transform.localPosition.z) == 2);
      }
    }

    void Start()
    //Audio, Cube, Mixing (side of the cube)
    {
      myAudioSource = GetComponent<AudioSource>();
      CreateCube();
      StartCoroutine(MixCube());
    }

    IEnumerator MixCube()
    //Start and Mixing Cube, Rotation and Sound
    {
      StartCoroutine(Rotate(BackPieces, new Vector3(-1, 0, 0)));
      myAudioSource.Play();
      yield return new WaitForSeconds(0.1f);
      StartCoroutine(Rotate(FrontPieces, new Vector3(1, 0, 0)));
      myAudioSource.Play();
      yield return new WaitForSeconds(0.5f);
      StartCoroutine(Rotate(RightPieces, new Vector3(0, 0, 1)));
      myAudioSource.Play();
      yield return new WaitForSeconds(0.4f);
      StartCoroutine(Rotate(LeftPieces, new Vector3(0, 0, -1)));
      myAudioSource.Play();
      yield return new WaitForSeconds(0.1f);
      StartCoroutine(Rotate(DownPieces, new Vector3(0, -1, 0)));
      myAudioSource.Play();
      yield return new WaitForSeconds(0.5f);
      StartCoroutine(Rotate(UpPieces, new Vector3(0, 1, 0)));
      myAudioSource.Play();
      yield return new WaitForSeconds(0.5f);
      scriptHallo.GetComponent<HalloScript>().HalloScreenOn();
    }

    void Update()
    {
      if(canRotate)
        CheckInput();
    }

    void CreateCube()
    {//https://www.youtube.com/watch?v=IISStnxa9jM&t=373s
      for(int x = 0; x < 3; x++)
        for(int y = 0; y < 3; y++)
          for(int z = 0; z < 3; z++)
          {
            GameObject go = Instantiate(CubePiecePrefab, CubeTransform, false);
            go.transform.localPosition = new Vector3(-x, -y, z);
            go.GetComponent<CubePieces>().SetColor(-x, -y, z);
            AllCubePieces.Add(go);
          }
      CubeCenterPiece = AllCubePieces[13];
    }

    void CheckInput()
  // Player: Rotation and Sound
    {
      if(Input.GetKeyDown(KeyCode.W))
        {
          StartCoroutine(Rotate(UpPieces, new Vector3(0, 1, 0)));
          myAudioSource.Play();
        }
      else if(Input.GetKeyDown(KeyCode.S))
        {
          StartCoroutine(Rotate(DownPieces, new Vector3(0, -1, 0)));
          myAudioSource.Play();
        }
      else if(Input.GetKeyDown(KeyCode.A))
        {
          StartCoroutine(Rotate(LeftPieces, new Vector3(0, 0, -1)));
          myAudioSource.Play();
        }
      else if(Input.GetKeyDown(KeyCode.D))
        {
        StartCoroutine(Rotate(RightPieces, new Vector3(0, 0, 1)));
        myAudioSource.Play();
        }
      else if(Input.GetKeyDown(KeyCode.Q))
        {
          StartCoroutine(Rotate(FrontPieces, new Vector3(1, 0, 0)));
          myAudioSource.Play();
        }
      else if(Input.GetKeyDown(KeyCode.E))
        {
          StartCoroutine(Rotate(BackPieces, new Vector3(-1, 0, 0)));
          myAudioSource.Play();
        }
    }

    IEnumerator Rotate(List<GameObject> pieces, Vector3 rotationVec)
    {//https://www.youtube.com/watch?v=IISStnxa9jM&t=373s
      canRotate = false;
      int angle = 0;
      while(angle < 90)
      {
        foreach(GameObject go in pieces)
        go.transform.RotateAround(CubeCenterPiece.transform.position, rotationVec, 5);
        angle +=5;
        yield return null;
      }
      canRotate = true;
    }
}
