# windows-volume-logon

Define o volume do Windows em um percentual fixo toda vez que o usuário faz logon.

Útil quando o Windows (por exemplo, em máquinas virtuais Hyper-V) sempre inicia com o volume em 100%.

Usa apenas **PowerShell** e a API de áudio nativa do Windows (Core Audio). **Não requer nenhum software de terceiros.**

## Compatibilidade

- Testado em: Windows 10 e Windows 11
- Não testado: Windows Server

## Arquivos

- `volume.bat`: espera alguns segundos após o logon e chama o PowerShell
- `volume.ps1`: tira o mudo e define o volume do dispositivo de saída padrão

## Instalação

1. Baixe ou clone o repositório e copie, da pasta windows/volume-logon, os arquivos `volume.bat` e `volume.ps1` para uma pasta fixa, por exemplo `C:\Scripts\`. Os dois arquivos precisam ficar na mesma pasta.
2. Abra o `volume.ps1` e ajuste o valor no final do arquivo (0.0 a 1.0):
   ```powershell
   [Audio]::SetVolume(0.40)   # 0.40 = 40%
   ```
3. Escolha uma forma de executar ao logon:

**Opção A: pasta Inicializar (mais simples)**
1. Pressione `Win + R`, digite `shell:startup` e dê Enter.
2. Cole ali um atalho para o `volume.bat`.

**Opção B: Agendador de Tarefas (mais robusto)**
1. Abra o Agendador de Tarefas e clique em *Criar Tarefa*.
2. Em *Gatilhos*, escolha **Ao fazer logon**.
3. Em *Ações*, escolha *Iniciar um programa* e aponte para o `volume.bat`.

## Como funciona

O `volume.bat` aguarda 10 segundos, para dar tempo ao serviço de áudio de iniciar, e executa o `volume.ps1` com `-ExecutionPolicy Bypass`. Esse parâmetro vale **apenas para essa execução** e não altera a política de execução do sistema.

## Limitações

- Afeta apenas o dispositivo de saída **padrão** no momento da execução. Se você troca de fone, caixa ou HDMI depois, o ajuste não acompanha.
- Se o áudio demorar a iniciar, aumente o tempo do `timeout` no `volume.bat`.

## Licença

Distribuído sob a licença [MIT](../../LICENSE), a mesma do repositório.