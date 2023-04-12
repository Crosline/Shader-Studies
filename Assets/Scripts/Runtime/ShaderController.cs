using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

namespace Runtime {
    public class ShaderController : MonoBehaviour {

        [SerializeField] private Text _shaderInfoText;

        [SerializeField] private Renderer[] _renderers;

        [SerializeField] private Material[] _materials;

        private int _currentIndex;

        private int _materialsLength;

        private void Start() {
#if UNITY_EDITOR
            Reset();
#endif
            _materialsLength = _materials.Length;
            _currentIndex = 0;
            SwapMaterials();
        }

        private void SwapMaterials() {
            var selectedMaterial = _materials[_currentIndex];
            foreach (var renderer in _renderers) renderer.material = selectedMaterial;
            _shaderInfoText.text = selectedMaterial.name;
        }

        public void ChangeMaterial(int offset) {
            _currentIndex = (_currentIndex + offset + _materialsLength) % _materialsLength;
            SwapMaterials();
        }
    
    
#if UNITY_EDITOR
        private void Reset() {
            var materialsPath = $"{Application.dataPath}{Path.DirectorySeparatorChar}Materials";
            var materialFiles = GetFilesAtDirectoryRecursive(
                materialsPath, "*.mat");

            _materialsLength = materialFiles.Length;
            _materials = new Material[_materialsLength];
        
            for (int i = 0; i < _materialsLength; i++) {
                var materialFile = GetProjectRelativePath(materialFiles[i]);
                var material = AssetDatabase.LoadAssetAtPath<Material>(materialFile);
                _materials[i] = material;
            }

            _renderers = GameObject.Find("Objects").transform.GetComponentsInChildren<Renderer>();
            _shaderInfoText = GameObject.Find("ShaderNameText").GetComponent<Text>();
        }

        private string[] GetFilesAtDirectoryRecursive(string path, string pattern) =>
            Directory.GetFiles(
                path,
                pattern,
                SearchOption.AllDirectories);

        private static string GetProjectRelativePath(string path) => $"Assets{path.Replace(Application.dataPath, "")}";
#endif
    }
}