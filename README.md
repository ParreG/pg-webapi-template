# pg-webapi-template

A personal .NET Web API template I built to stop copy-pasting the same boilerplate every time I start a new project. It follows a four-layer architecture (Controllers, Services, Repositories, Data) and comes with a bunch of things already set up so I can just focus on the actual buisness logic.

---

## What's included

- **ASP.NET Core 9** Web API
- **Entity Framework Core 9** with SQL Server
- **Scalar** instead of Swagger (dark mode, cus light attracts bugs XD)
- **Four-layer architecture** – Controllers, Services, Repositories, Data
- **BaseEntity** with Id, CreatedAt, UpdatedAt and soft delete (DeletedAt)
- **Generic IRepository\<T\>** interface as a base for all repositories
- **ServiceResponse\<T\>** record for consistent service responses
- **Validations.resx** – all user-facing error messages and validation strings in one place, with PG-prefixed error codes (PG400, PG404 etc.)
- **DependencyInjections** extension method to keep Program.cs clean
- **ValidationController** – a default endpoint that returns all validation messages as JSON, useful for frontend
- **xUnit** test project already set up with a sample test
- **GitHub Actions** CI pipeline that builds and runs tests on every push to main
- **init.ps1** script for quick project initialization (more on that below)

---

## Project structure

```
pg-webapi-template/
├── .github/
│   └── workflows/
│       └── ci.yml
├── .template.config/
│   └── template.json
├── src/
│   └── PG.ProjectName/
│       ├── Common/
│       ├── Configurations/
│       ├── Controllers/
│       ├── Data/
│       ├── DTOs/
│       ├── Models/
│       ├── Repositories/
│       │   └── Interfaces/
│       ├── Resources/
│       ├── Services/
│       │   └── Interfaces/
│       ├── appsettings.json
│       ├── appsettings.Development.json
│       └── Program.cs
├── tests/
│   └── PG.ProjectName.Tests/
│       └── ValidationServiceTests.cs
├── init.ps1
└── README.md
```

---

## How to use it
 
There are three ways to use this template depending on what you prefer.
 
---
### Option 1 – dotnet new (recommended)
 
You don't need to clone this repo. All you need is .NET installed on your machine.
 
Open **PowerShell**, **Terminal** or **Command Prompt** – anywhere you can run dotnet commands – and install the template directly from GitHub. This only needs to be done once:
 
```bash
dotnet new install gh:ParreG/pg-webapi-template
```
 
After that, navigate to the folder where you want to create your new project and run:
 
```bash
dotnet new pg-webapi -n "Your.ProjectName"
```
 
A new folder called `Your.ProjectName` will be created with all the files already set up. Every occurrence of `PG.ProjectName` is replaced with your project name – in file names, folder names and inside the code.
 
To uninstall the template if you no longer need it:
 
```bash
dotnet new uninstall gh:ParreG/pg-webapi-template
```

---
### Option 2 – GitHub Template Repository

If you have access to this repo on GitHub, you can click the **"Use this template"** button at the top to create a new repo based on it. You'll get all the files but `PG.ProjectName` won't be renamed automatically, so you need to use the init script below.

---

### Option 3 – init.ps1 script

If you created a new repo from this template via GitHub, clone it and run the init script:

```bash
git clone https://github.com/your-username/your-new-repo.git
cd your-new-repo
```

Then right-click `init.ps1` and choose **Run with PowerShell**, or run it from the terminal:

```bash
.\init.ps1
```

The script will ask you for a project name, replace all occurrences of `PG.ProjectName` throughout the entire codebase, and then delete itself. After that your project is ready to push.

> **Note:** Make sure your new repo already has a remote set up before running the script if you want it to push automatically.

---

## Database setup

The template uses LocalDB by default for local development. The connection string in `appsettings.Development.json` uses your project name as the database name so you dont have to configure anything.

For sensitive credentials (like a real SQL Server with username and password) use **User Secrets**. Right-click the project in Visual Studio and choose **Manage User Secrets**.
---

## Running the project

```bash
cd src/Your.ProjectName
dotnet run
```

Scalar API docs will open automaticly at:

```
https://localhost:{port}/scalar/v1
```

---

## Running tests

```bash
dotnet test
```

---

## Tech stack

| Technology | Version |
|---|---|
| .NET | 9.0 |
| ASP.NET Core | 9.0 |
| Entity Framework Core | 9.x |
| xUnit | 2.9.x |
| Scalar | Latest |

---

Built by [Parman Gitijah](https://github.com/ParreG)
