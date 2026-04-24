<div align="center">
<br/>
<div align="center">
<br/>

```
███████╗██╗  ██╗██╗   ██╗██████╗     ███████╗███╗   ██╗███████╗██████╗  ██████╗██╗   ██╗
██╔════╝╚██╗██╔╝██║   ██║██╔══██╗    ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔════╝╚██╗ ██╔╝
█████╗   ╚███╔╝ ██║   ██║██████╔╝    █████╗  ██╔██╗ ██║█████╗  ██████╔╝██║  ███╗╚████╔╝
██╔══╝   ██╔██╗ ██║   ██║██╔═══╝     ██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██║   ██║ ╚██╔╝
███████╗██╔╝ ██╗╚██████╔╝██║         ███████╗██║ ╚████║███████╗██║  ██║╚██████╔╝  ██║
╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝         ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═╝
```
 
### Optimización inteligente de gasto en combustible · Android · Flutter
 
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2B%20BLoC-6C3483?style=flat-square)](https://bloclibrary.dev)
[![CI/CD](https://img.shields.io/badge/CI%2FCD-Gitea%20Actions-609926?style=flat-square&logo=gitea&logoColor=white)](https://gitea.io)
[![Mirror](https://img.shields.io/badge/Mirror-GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com)
 
<br/>
</div>
---
 
## ✦ Sobre el Proyecto
 
**ExUp Energy** es una aplicación Android construida con Flutter que permite a los usuarios localizar gasolineras en tiempo real, comparar precios de combustible y detectar automáticamente oportunidades de ahorro en su zona geográfica.
 
El proyecto nace con un objetivo técnico claro: aplicar estándares de ingeniería de software de nivel profesional en un entorno móvil multiplataforma, integrando datos geoespaciales en tiempo real con una arquitectura limpia, testeable y mantenible a largo plazo.
 
---
 
## 🏗️ Ingeniería de Software
 
### Clean Architecture
 
La arquitectura del proyecto separa estrictamente las responsabilidades en tres capas independientes, asegurando que los cambios en una capa no propaguen efectos no deseados al resto del sistema.
 
```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION                            │
│   BLoC / Cubit   ──   Widgets   ──   Pages   ──   Routes   │
│   (Gestión de estado y navegación, sin lógica de negocio)   │
├─────────────────────────────────────────────────────────────┤
│                       DOMAIN                                │
│       Entities   ──   Use Cases   ──   Repository Interfaces│
│      (Núcleo puro de Dart — sin dependencias externas)      │
├─────────────────────────────────────────────────────────────┤
│                        DATA                                 │
│   Repositories   ──   Mappers   ──   Remote / Local Sources │
│        (Implementaciones concretas, Retrofit, Hive)         │
└─────────────────────────────────────────────────────────────┘
```
 
| Capa | Responsabilidad | Dependencias externas |
|---|---|---|
| **Presentation** | UI, estado, navegación | Flutter, BLoC |
| **Domain** | Reglas de negocio, contratos | Ninguna (Dart puro) |
| **Data** | Fuentes de datos, serialización | Dio, Hive, Mappers |
 
> La capa **Domain** no importa ningún paquete externo. Esto garantiza que el núcleo de la aplicación sea completamente testeable de forma unitaria y portable a cualquier plataforma.
 
---
 
### BLoC Pattern — Gestión de Estado
 
Cada feature encapsula su propio BLoC o Cubit, siguiendo el flujo unidireccional de datos:
 
```
UI Event ──► BLoC ──► Use Case ──► Repository ──► Data Source
                │
                ▼
           State Stream ──► UI Rebuild
```
 
Este patrón asegura que la interfaz sea un reflejo puro del estado, sin lógica de negocio embebida en los widgets.
 
---
 
### Sistema de Diseño (Atomic Design)
 
Los componentes de UI se organizan jerárquicamente para maximizar la reutilización y la consistencia visual:
 
```
Atoms          →   Molecules          →   Organisms
────────────       ──────────────         ────────────────────
Botones            Input Groups           Forms completos
Textos/Labels      List Tiles             Headers de pantalla
Iconos             Price Cards            Station Detail Cards
Badges             Search Bars            Map Overlays
Loaders            Chip Groups            Bottom Sheets
```
 
Todos los componentes consumen **tokens de diseño** centralizados en `core/theme/`, asegurando coherencia de colores, tipografía y espaciado en toda la aplicación.
 
---
 
## 📂 Estructura del Proyecto
 
```
lib/
│
├── core/                          # Infraestructura transversal
│   ├── network/
│   │   ├── dio_client.dart        # Cliente HTTP configurado
│   │   ├── interceptors/          # Auth, logging, error handling
│   │   └── api_endpoints.dart     # Constantes de endpoints
│   ├── theme/
│   │   ├── app_theme.dart         # Light / Dark theme
│   │   ├── design_tokens.dart     # Colores, tipografía, espaciado
│   │   └── theme_cubit.dart       # Cambio dinámico de tema
│   └── widgets/                   # Librería de componentes
│       ├── atoms/                 # Botones, textos, iconos
│       ├── molecules/             # Input groups, list tiles
│       └── organisms/             # Forms, headers, cards
│
└── features/                      # Módulos de negocio aislados
    │
    ├── auth/                      # Autenticación
    │   ├── data/                  # Remote source, mapper, repo impl
    │   ├── domain/                # Entities, use cases, repo interface
    │   └── presentation/          # BLoC, pages, widgets
    │
    ├── gas_stations/              # Core: localización y precios
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    └── user/                      # Perfil y preferencias
        ├── data/
        ├── domain/
        └── presentation/
```
 
---
 
## ⚙️ Infraestructura & CI/CD
 
> [!NOTE]
> Este repositorio es un **mirror público** sincronizado automáticamente desde la instancia privada de Gitea. El código fuente de verdad vive en infraestructura propia.
 
El pipeline de entrega está completamente automatizado mediante **Gitea Actions** en un entorno Dockerizado:
 
```
git push → Gitea (source of truth)
    │
    ▼
Gitea Actions Runner (Docker)
    │
    ├── flutter pub get
    ├── flutter analyze
    ├── flutter test
    └── flutter build apk --release
            │
            ▼
    APK publicada en servidor de descargas
    (Nginx + Traefik · TLS automático)
            │
            ▼
    Mirror automático → GitHub (visibilidad pública)
```
 
| Etapa | Herramienta | Descripción |
|---|---|---|
| **Source Control** | Gitea (self-hosted) | Repositorio privado principal |
| **CI Runner** | Gitea Actions (Docker) | Build, test y análisis estático |
| **Artifact Hosting** | Nginx + Traefik | Servidor de descarga de APKs |
| **Public Mirror** | GitHub | Visibilidad pública del proyecto |
 
---
 
## 🚀 Instalación y Desarrollo Local
 
### Prerrequisitos
 
- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.0.0`
- Dart `>=3.0.0`
- Android Studio o VS Code con extensión Flutter
- Dispositivo Android o emulador configurado
### Setup
 
```bash
# 1. Clonar el repositorio
git clone https://github.com/victorponce/exup-energy-mobile.git
cd exup-energy-mobile
 
# 2. Instalar dependencias
flutter pub get
 
# 3. Configurar variables de entorno
cp .env.example .env
# Editar .env con tus credenciales de API
 
# 4. Generar código (si aplica)
dart run build_runner build --delete-conflicting-outputs
 
# 5. Lanzar la aplicación
flutter run
```
 
### Comandos útiles
 
```bash
# Análisis estático
flutter analyze
 
# Ejecutar tests unitarios
flutter test
 
# Build APK release
flutter build apk --release
 
# Build con flavor específico
flutter build apk --flavor production -t lib/main_production.dart
```
 
---
 
<div align="center">
<br/>
**Diseñado e implementado por [Victor Ponce](https://victorponce.dev)**
 
*Flutter · Clean Architecture · Self-Hosted Infrastructure*
 
<br/>
</div>