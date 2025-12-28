using System.Collections;
using System.Collections.Generic;
using Eccentric;
using UnityEngine;

public class Games : MonoBehaviour
{
    public CameraMove bigGame;
    public Player2D smallGame;
   
    // Update is called once per frame
    private void OnMouseUpAsButton()
    {
        smallGame.enabled = true;
        bigGame.enabled = false;
    }

    private void OnMouseExit()
    {
        smallGame.enabled = false;
        bigGame.enabled = true;
    }
}

//https://www.youtube.com/watch?v=QwtQbnd4734&t=307s