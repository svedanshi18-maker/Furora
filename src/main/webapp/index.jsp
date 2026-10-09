
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Furora</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f7f1e9;
            color: #38251d;
            min-height: 100vh;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 22px 8%;
            background: #fffaf4;
            border-bottom: 1px solid #e7d8c8;
        }

        .logo {
            font-size: 29px;
            font-weight: 800;
            letter-spacing: 1px;
            color: #70452f;
        }

        .logo span {
            color: #b17b53;
        }

        .tagline {
            font-size: 13px;
            color: #806b5b;
            letter-spacing: 1px;
        }

        .hero {
            text-align: center;
            padding: 65px 20px 42px;
        }

        .eyebrow {
            color: #986746;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 3px;
            text-transform: uppercase;
            margin-bottom: 18px;
        }

        h1 {
            font-family: Georgia, serif;
            font-size: clamp(36px, 5vw, 58px);
            color: #4b3024;
            margin-bottom: 17px;
            font-weight: 500;
        }

        .hero p {
            color: #796657;
            font-size: 16px;
            line-height: 1.8;
            max-width: 560px;
            margin: 0 auto;
        }

        .cards {
            max-width: 1120px;
            margin: 15px auto 65px;
            padding: 0 24px;
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 24px;
        }

        .card {
            background: #fffaf4;
            border: 1px solid #e6d5c4;
            border-radius: 18px;
            padding: 32px 25px;
            display: flex;
            flex-direction: column;
            min-height: 330px;
            box-shadow: 0 8px 25px rgba(75, 48, 36, 0.06);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 32px rgba(75, 48, 36, 0.12);
        }

        .icon {
            width: 62px;
            height: 62px;
            display: grid;
            place-items: center;
            background: #eee0d0;
            border-radius: 16px;
            font-size: 30px;
            margin-bottom: 24px;
        }

        .admin .icon {
            background: #e5d3c2;
        }

        .card h2 {
            font-family: Georgia, serif;
            font-size: 27px;
            font-weight: 500;
            margin-bottom: 12px;
            color: #4b3024;
        }

        .card p {
            color: #79695d;
            font-size: 14px;
            line-height: 1.8;
            margin-bottom: 26px;
            flex-grow: 1;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            display: inline-block;
            flex: 1;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            padding: 12px 8px;
            font-size: 13px;
            font-weight: 700;
            transition: background 0.2s;
        }

        .btn-primary {
            background: #70452f;
            color: #fffaf4;
            border: 1px solid #70452f;
        }

        .btn-primary:hover {
            background: #523321;
        }

        .btn-secondary {
            color: #70452f;
            border: 1px solid #bda18b;
            background: transparent;
        }

        .btn-secondary:hover {
            background: #f0e4d7;
        }

        .admin-note {
            font-size: 12px !important;
            margin-top: 10px;
            margin-bottom: 0 !important;
            color: #987e6a !important;
        }

        footer {
            text-align: center;
            padding: 24px;
            border-top: 1px solid #e7d8c8;
            color: #8a7768;
            font-size: 12px;
            letter-spacing: 0.5px;
        }

        @media (max-width: 850px) {
            .cards {
                grid-template-columns: 1fr;
                max-width: 480px;
            }

            .hero {
                padding-top: 45px;
            }

            header {
                padding: 18px 6%;
            }

            .tagline {
                display: none;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="logo">FUR<span>ORA</span></div>
    <div class="tagline">A LITTLE LOVE. A FOREVER HOME.</div>
</header>

<main>
    <section class="hero">
        <div class="eyebrow">Find your place in their story</div>
        <h1>Welcome to Furora</h1>
        <p>
            Choose how you want to access the platform.
            Every connection brings us one step closer to a loving home
            for every pet.
        </p>
    </section>

    <section class="cards">

        <!-- Adopter -->
        <article class="card">
            <div class="icon">🐾</div>
            <h2>Adopter</h2>
            <p>
                Discover pets waiting for a loving family,
                explore their stories, and apply for adoption.
            </p>
            <div class="actions">
                <a class="btn btn-primary"
                   href="login.jsp?role=ADOPTER">Login</a>
                <a class="btn btn-secondary"
                   href="register.jsp?role=ADOPTER">Sign up</a>
            </div>
        </article>

        <!-- Shelter -->
        <article class="card">
            <div class="icon">🏡</div>
            <h2>Shelter</h2>
            <p>
                Manage pet listings, help animals find families,
                and review adoption applications.
            </p>
            <div class="actions">
                <a class="btn btn-primary"
                   href="login.jsp?role=SHELTER">Login</a>
                <a class="btn btn-secondary"
                   href="register.jsp?role=SHELTER">Sign up</a>
            </div>
        </article>

        <!-- Administrator -->
        <article class="card admin">
            <div class="icon">🔐</div>
            <h2>Administrator</h2>
            <p>
                Access administrative tools to oversee users,
                pet listings, and platform activity.
            </p>
            <div class="actions">
                <a class="btn btn-primary"
                   href="login.jsp?role=ADMIN">Admin Login</a>
            </div>
            <p class="admin-note">
                Existing administrator accounts only.
                Public admin registration is disabled.
            </p>
        </article>

    </section>
</main>

<footer>
    FURORA &nbsp;•&nbsp; MADE WITH LOVE FOR EVERY PAW
</footer>

</body>
</html>
