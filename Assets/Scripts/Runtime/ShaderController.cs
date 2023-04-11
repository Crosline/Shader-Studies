using System;
using UnityEngine;

public class ShaderController : MonoBehaviour
{
    [SerializeField]
    private Renderer[] _renderers;
    [SerializeField]
    private Material[] _materials;
    private int _currentIndex;
    private int _materialsLength;

    private void Start()
    {
        _currentIndex = 0;
        _materialsLength = _materials.Length;
        
        SwapMaterials();
    }

    private void SwapMaterials()
    {
        foreach (var renderer in _renderers) renderer.material = _materials[_currentIndex];
    }

    public void ChangeMaterial(int offset)
    {
        _currentIndex = (_currentIndex + offset + _materialsLength) % (_materialsLength);
        SwapMaterials();
    }
}
