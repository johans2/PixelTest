using UnityEngine;
using System.Collections;

public class Rotate : MonoBehaviour {

    public float speed = 1;

    void Update() {
        transform.Rotate(0f, speed, 0f);
    }

}
