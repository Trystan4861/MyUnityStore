# Triplanar Shader for Unity

- **Autor**: [@trystan4861](https://github.com/Trystan4861)
- **Fecha**: 02-12-2024
- **Licencia**: [MIT](https://opensource.org/licenses/MIT)

## Descripción

Este shader permite aplicar una textura a un objeto usando un enfoque triplanar, lo que significa que la textura se proyecta desde tres direcciones (ejes X, Y, Z). Es ideal para crear superficies donde la textura debe aplicarse sin deformarse, como en objetos de geometría compleja o superficies grandes.

Este shader también permite controlar el tamaño de la textura mediante el parámetro `_Scale` (Texture Scale en el Inspector del Material), el cual es proporcional al tamaño de la textura. Aumentar el valor de `_Scale` hace que la textura se vea más grande, mientras que disminuir el valor hace que la textura se repita más veces y se vea más pequeña.

## Características

- Proyección triplanar de la textura.
- Control del tamaño de la textura mediante el parámetro `_Scale`, donde un valor mayor de `_Scale` hace que la textura se vea más grande y un valor menor la hace más pequeña.
- Suavizado de transiciones entre las caras al proyectar la textura.
- Utilizable en Unity en cualquier material.

## Cómo usarlo

1. **Crear un material**: Aplica este shader en un nuevo material dentro de Unity.
2. **Ajustar la textura**: Asigna una textura al campo `_MainTex`.
3. **Ajustar el tamaño de la textura**: Modifica el valor de `_Scale` en el material para cambiar el tamaño de la textura. Cuanto mayor sea el valor de `_Scale`, más grande se verá la textura.

## Requisitos

- Unity 2019.4 o superior.
- No requiere ningún paquete adicional.

## Ejemplo de Modificación en tiempo de ejecución

```csharp
Material material = GetComponent<Renderer>().material;
material.SetFloat("_Scale", 2.0f);  // Cambia el tamaño de la textura, haciendo que sea más grande.
```
