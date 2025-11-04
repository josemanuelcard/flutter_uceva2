# 🎓 Gestión de Universidades - Flutter con Firebase

Aplicación Flutter para la gestión de universidades con integración completa de Firebase Firestore. Permite realizar operaciones CRUD (Create, Read, Update, Delete) con sincronización en tiempo real.

## 📋 Descripción

Este proyecto es un módulo de gestión de universidades desarrollado en Flutter que utiliza Firebase Cloud Firestore como base de datos. La aplicación permite crear, listar, editar y eliminar universidades con sincronización en tiempo real entre dispositivos.

### ✨ Características Principales

- ✅ **Operaciones CRUD completas** - Crear, leer, actualizar y eliminar universidades
- 🔄 **Sincronización en tiempo real** - Los cambios se reflejan automáticamente en todos los dispositivos
- 📱 **Multiplataforma** - Funciona en Android, iOS, Web, Windows, Linux y macOS
- 🎨 **Material Design 3** - Interfaz moderna y responsive
- ✅ **Validaciones** - Validación de campos requeridos y formato de URL
- 🛡️ **Manejo de errores** - Pantallas informativas en caso de errores
- 🔥 **Firebase integrado** - Configuración completa con FlutterFire CLI

## 🏗️ Arquitectura del Proyecto

```
lib/
├── main.dart                          # Punto de entrada y configuración de Firebase
├── firebase_options.dart              # Configuración de Firebase para todas las plataformas
├── models/
│   └── universidad.dart              # Modelo de datos Universidad
├── services/
│   └── universidad_service.dart      # Servicio CRUD para Firestore
└── screens/
    ├── universidades_list_screen.dart  # Pantalla de listado con StreamBuilder
    └── universidad_form_screen.dart    # Formulario de creación/edición
```

## 📦 Modelo de Datos

La colección `universidades` en Firestore contiene documentos con la siguiente estructura:

```json
{
  "nit": "890.123.456-7",
  "nombre": "UCEVA",
  "direccion": "Cra 27A #48-144, Tuluá - Valle",
  "telefono": "+57 602 2242202",
  "pagina_web": "https://www.uceva.edu.co"
}
```

### Campos del Modelo

| Campo | Tipo | Descripción | Validación |
|-------|------|-------------|------------|
| `nit` | String | Número de identificación tributaria | Requerido, no vacío |
| `nombre` | String | Nombre de la universidad | Requerido, no vacío |
| `direccion` | String | Dirección física | Requerido, no vacío |
| `telefono` | String | Número de teléfono | Requerido, no vacío |
| `pagina_web` | String | URL del sitio web | Requerido, formato URL válido (http:// o https://) |

## 🚀 Requisitos Previos

- Flutter SDK 3.9.0 o superior
- Dart SDK 3.9.0 o superior
- Cuenta de Firebase
- Node.js (para FlutterFire CLI, opcional)
- Git

## 📥 Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/josemanuelcard/flutter_uceva2.git
cd flutter_uceva2
```

### 2. Instalar Dependencias

```bash
flutter pub get
```

### 3. Configurar Firebase

#### Opción A: Usando FlutterFire CLI (Recomendado)

```bash
# Instalar Firebase CLI (si no está instalado)
npm install -g firebase-tools

# Autenticarse en Firebase
firebase login

# Configurar Firebase para el proyecto
flutterfire configure --project=flutter-uceva2
```

Esto generará automáticamente el archivo `lib/firebase_options.dart` con la configuración para todas las plataformas.

#### Opción B: Configuración Manual

1. **Crear proyecto en Firebase Console**
   - Ve a [Firebase Console](https://console.firebase.google.com/)
   - Crea un nuevo proyecto o selecciona uno existente

2. **Configurar Android**
   - Agrega una app Android en Firebase Console
   - Package name: `com.example.flutter_uceva2`
   - Descarga `google-services.json`
   - Colócalo en `android/app/google-services.json`

3. **Configurar Web**
   - Agrega una app Web en Firebase Console
   - Copia la configuración y actualiza `web/index.html`

4. **Habilitar Firestore Database**
   - Ve a Firestore Database en Firebase Console
   - Clic en "Crear base de datos"
   - Selecciona "Comenzar en modo de prueba"
   - Elige la ubicación (ej: `us-central1`)

## 🎯 Uso

### Ejecutar la Aplicación

```bash
# Ver dispositivos disponibles
flutter devices

# Ejecutar en Chrome (Web)
flutter run -d chrome

# Ejecutar en Android
flutter run -d android

# Ejecutar en iOS (requiere Mac)
flutter run -d ios
```

### Funcionalidades de la App

1. **Listar Universidades**
   - Al abrir la app, se muestra la lista de universidades
   - Los datos se sincronizan en tiempo real
   - Si no hay universidades, se muestra un mensaje informativo

2. **Crear Universidad**
   - Toca el botón `+` (FloatingActionButton)
   - Completa el formulario con todos los campos
   - Los campos con `*` son obligatorios
   - La URL debe tener formato válido (http:// o https://)
   - Toca "Crear Universidad" para guardar

3. **Editar Universidad**
   - En la lista, toca el ícono de editar (✏️)
   - Modifica los campos necesarios
   - Toca "Actualizar Universidad" para guardar cambios

4. **Eliminar Universidad**
   - En la lista, toca el ícono de eliminar (🗑️)
   - Confirma la eliminación en el diálogo
   - La universidad se elimina permanentemente

## 🛠️ Tecnologías Utilizadas

- **Flutter** - Framework multiplataforma
- **Dart** - Lenguaje de programación
- **Firebase Core** - Integración con Firebase
- **Cloud Firestore** - Base de datos NoSQL en tiempo real
- **FlutterFire CLI** - Herramienta de configuración de Firebase
- **Material Design 3** - Sistema de diseño moderno

## 📁 Estructura del Proyecto

```
flutter_uceva2/
├── android/              # Configuración Android
├── ios/                  # Configuración iOS
├── web/                  # Configuración Web
├── lib/
│   ├── main.dart        # Punto de entrada
│   ├── firebase_options.dart  # Configuración Firebase
│   ├── models/          # Modelos de datos
│   ├── services/        # Servicios y lógica de negocio
│   └── screens/         # Pantallas de la aplicación
├── test/                # Pruebas unitarias
├── pubspec.yaml         # Dependencias del proyecto
└── README.md            # Este archivo
```

## 🔄 Flujo de Trabajo GitFlow

El proyecto utiliza GitFlow para la gestión de ramas:

- **`main`** - Rama principal de producción
- **`dev`** - Rama de desarrollo
- **`feature/*`** - Ramas de características nuevas

### Proceso de Desarrollo

1. Crear rama feature desde `dev`:
   ```bash
   git checkout dev
   git checkout -b feature/nueva-funcionalidad
   ```

2. Desarrollar y hacer commits:
   ```bash
   git add .
   git commit -m "feat: descripción de la funcionalidad"
   ```

3. Subir la feature y crear Pull Request:
   ```bash
   git push -u origin feature/nueva-funcionalidad
   ```

4. Mergear a `dev` después de revisión

## 🧪 Pruebas

```bash
# Ejecutar pruebas unitarias
flutter test

# Ejecutar pruebas con cobertura
flutter test --coverage
```

## 📝 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  firebase_core: ^3.15.2
  cloud_firestore: ^5.6.12
```

## 🔒 Seguridad

- ⚠️ **Importante**: Los archivos `google-services.json` y `GoogleService-Info.plist` están en `.gitignore` por seguridad
- Cada desarrollador debe descargar sus propios archivos de configuración desde Firebase Console
- Las reglas de Firestore deben configurarse apropiadamente para producción

## 🐛 Solución de Problemas

### Error: "FirebaseOptions cannot be null"
- Verifica que `firebase_options.dart` existe y está actualizado
- Ejecuta `flutterfire configure` nuevamente

### Error: "MissingPluginException"
```bash
flutter clean
flutter pub get
flutter run
```

### Error: "Firebase not initialized"
- Verifica que Firestore Database esté habilitado en Firebase Console
- Verifica que las reglas de seguridad permitan lectura/escritura

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'feat: Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto es parte de un taller académico de la UCEVA.

## 👥 Autor

Desarrollado como parte del taller de Flutter con Firebase.

## 🔗 Enlaces Útiles

- [Documentación de Flutter](https://docs.flutter.dev/)
- [Documentación de Firebase](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Cloud Firestore](https://firebase.google.com/docs/firestore)

---

**Nota**: Este proyecto fue desarrollado siguiendo las mejores prácticas de Flutter y Firebase, con una arquitectura limpia y escalable.
