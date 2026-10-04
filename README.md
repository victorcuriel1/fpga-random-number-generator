# Generador de Números Pseudoaleatorios en FPGA

Proyecto de Sistemas Digitales basado en la implementación de un generador de números pseudoaleatorios en FPGA utilizando un Registro de Desplazamiento de Retroalimentación Lineal (LFSR) de tipo Galois.

El sistema fue desarrollado en VHDL e incluye una máquina de estados, un divisor de frecuencia, la lógica del LFSR y la visualización del resultado en un display de 7 segmentos.

## Tecnologías utilizadas

- FPGA
- VHDL
- LFSR de Galois
- Máquina de estados
- Test Bench
- Simulación digital

## Funcionamiento

El generador utiliza un LFSR de 16 bits con retroalimentación mediante operaciones XOR.

El sistema es controlado mediante las señales:

- `run`
- `stop`
- `reset`

La secuencia generada se procesa y se muestra mediante un display de 7 segmentos.

## Arquitectura

El diseño incluye:

- LFSR de Galois de 16 bits
- Divisor de frecuencia
- Máquina de estados
- Lógica de control
- Decodificación para display de 7 segmentos

## Simulación

Se desarrolló un test bench para verificar el funcionamiento del sistema antes de su implementación física en FPGA.

## Implementación

El diseño fue implementado finalmente en una FPGA, obteniendo correctamente distintos valores pseudoaleatorios visibles en el display.

## Archivos

Código principal:

`src/random_generator.vhd`

Test bench:

`simulation/random_generator_tb.vhd`

## Documentación

El informe completo del proyecto está disponible aquí:

[Ver informe del proyecto](docs/Project_Report.pdf)

## Autores

- Victor Curiel
- Ximena Quenhan

Universidad Nacional de Asunción  
Facultad de Ingeniería  
Ingeniería Mecatrónica

## Licencia

Este proyecto está distribuido bajo la licencia MIT.
