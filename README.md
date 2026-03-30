# Solveur de Chaleur 1D Transitoire

Solveur numérique de l'équation de la chaleur en une dimension, développé en **Fortran 90** moderne.

## Description

Ce projet implémente la résolution de l'équation de la chaleur transitoire :

$$\frac{\partial T}{\partial t} = \alpha \frac{\partial^2 T}{\partial x^2} + \frac{\alpha}{k} q(x)$$

avec :
- **Méthode de Crank-Nicolson** (ordre 2 en temps et en espace)
- **Conditions aux limites de Robin** (convection naturelle aux deux extrémités)
- **Source de chaleur gaussienne** centrée en x₀

## Architecture

| Module | Fichier | Rôle |
|--------|---------|------|
| `precision` | `mod_precision.f90` | Précision numérique double |
| `parametre` | `mod_params.f90` | Lecture des paramètres (namelist) |
| `grille` | `discreditation.f90` | Grille spatiale + source gaussienne |
| `solver` | `solver.f90` | Matrice tridiagonale + algorithme de Thomas |
| `mod_io` | `mod_io.f90` | Sauvegarde des résultats |
| Programme principal | `main_solveur.f90` | Orchestration de la simulation |

## Compilation

```bash
gfortran -O2 -o solveur mod_precision.f90 mod_params.f90 discreditation.f90 solver.f90 mod_io.f90 main_solveur.f90
```

## Utilisation

Modifiez les paramètres dans `parametre.txt` puis lancez :

```bash
./solveur
gnuplot plot_all.gp
```

## Paramètres

| Paramètre | Description | Unité |
|-----------|-------------|-------|
| `n` | Nombre de points | -- |
| `L` | Longueur de la barre | m |
| `dt` | Pas de temps | s |
| `t_max` | Temps final | s |
| `lambda` | Conductivité thermique | W/(m·K) |
| `rho` | Masse volumique | kg/m³ |
| `cp` | Capacité thermique | J/(kg·K) |
| `h` | Coefficient de convection | W/(m²·K) |
| `T_inf` | Température ambiante | K |
| `T_init` | Température initiale | K |
| `A` | Amplitude source gaussienne | W/m³ |
| `x0` | Centre de la gaussienne | m |
| `sigma` | Largeur de la gaussienne | m |

## Résultats

Le solveur génère :
- `temp_en_fon_temps` — températures à chaque instant et position
- `evolution_temperature.gif` — animation de l'évolution thermique

## Auteur

**Mahougnon Calixte ZATTA**  
UNSTIM — Génie Mathématique et Modélisation
