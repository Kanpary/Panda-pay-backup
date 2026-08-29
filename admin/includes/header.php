<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel Admin</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        :root {
            --primary-color: #3b82f6; /* Bright Blue */
            --primary-hover: #2563eb;
            --bg-color: #000000; /* Solid Black */
            --card-bg: #111111; /* Very Dark Gray */
            --sidebar-bg: #050505; /* Almost Black */
            --text-color: #e5e7eb; /* Light Gray */
            --text-muted: #9ca3af;
            --border-color: #222222;
            --input-bg: #1a1a1a;
            --sidebar-width: 260px;
        }
        * {
            box-sizing: border-box;
        }
        body {
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            margin: 0;
            display: flex;
            min-height: 100vh;
        }
        /* Scrollbar styling */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: var(--bg-color); 
        }
        ::-webkit-scrollbar-thumb {
            background: #333; 
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #444; 
        }

        .sidebar {
            width: var(--sidebar-width);
            background-color: var(--sidebar-bg);
            border-right: 1px solid var(--border-color);
            color: var(--text-color);
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100%;
            z-index: 100;
        }
        .sidebar-header {
            padding: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid var(--border-color);
        }
        .sidebar-header h2 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            color: white;
            text-transform: uppercase;
        }
        .sidebar-menu {
            list-style: none;
            padding: 1rem 0;
            margin: 0;
            flex-grow: 1;
            overflow-y: auto;
        }
        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 0.875rem 1.5rem;
            color: var(--text-muted);
            text-decoration: none;
            transition: all 0.2s ease;
            font-weight: 500;
            border-left: 3px solid transparent;
        }
        .sidebar-menu li a:hover, .sidebar-menu li a.active {
            background-color: rgba(59, 130, 246, 0.1);
            color: white;
            border-left-color: var(--primary-color);
        }
        .sidebar-menu li a i {
            margin-right: 0.75rem;
            width: 20px;
            height: 20px;
        }
        .main-content {
            margin-left: var(--sidebar-width);
            flex-grow: 1;
            padding: 2rem;
            max-width: 100%;
        }
        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 1rem;
        }
        .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: white;
            margin: 0;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background-color: var(--card-bg);
            padding: 1.5rem;
            border-radius: 0.75rem;
            border: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-2px);
            border-color: #444;
        }
        .stat-icon {
            background-color: rgba(59, 130, 246, 0.1);
            color: var(--primary-color);
            padding: 1rem;
            border-radius: 0.75rem;
            margin-right: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .stat-info h3 {
            margin: 0;
            font-size: 0.875rem;
            color: var(--text-muted);
            font-weight: 500;
        }
        .stat-info p {
            margin: 0.25rem 0 0 0;
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
        }
        
        /* Table Styles */
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        th, td {
            text-align: left;
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
        }
        th {
            background-color: rgba(255, 255, 255, 0.03);
            font-weight: 600;
            color: var(--text-muted);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        td {
            color: var(--text-color);
            font-size: 0.95rem;
        }
        tr:last-child td {
            border-bottom: none;
        }
        tr:hover td {
            background-color: rgba(255, 255, 255, 0.02);
        }

        /* Status Badges */
        .status-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }
        .status-paid, .status-approved, .status-win, .status-online {
            background-color: rgba(16, 185, 129, 0.2);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        .status-pending {
            background-color: rgba(245, 158, 11, 0.2);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.2);
        }
        .status-failed, .status-rejected, .status-loss, .status-offline {
            background-color: rgba(239, 68, 68, 0.2);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        /* Buttons & Forms */
        .btn {
            padding: 0.6rem 1.2rem;
            border-radius: 0.5rem;
            border: none;
            cursor: pointer;
            font-size: 0.875rem;
            text-decoration: none;
            display: inline-block;
            font-weight: 500;
            transition: background-color 0.2s;
        }
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        .btn-primary:hover {
            background-color: var(--primary-hover);
        }
        .form-control {
            width: 100%;
            padding: 0.75rem;
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            color: white;
            font-family: inherit;
            box-sizing: border-box;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-muted);
            font-size: 0.9rem;
        }
        
        /* Utils */
        .text-right { text-align: right; }
        .mt-4 { margin-top: 1.5rem; }

        /* Mobile Responsive Styles */
        .mobile-toggle {
            display: none;
            position: fixed;
            top: 1rem;
            left: 1rem;
            z-index: 1001;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            padding: 0.5rem;
            border-radius: 0.5rem;
            color: white;
            cursor: pointer;
        }
        
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 99;
            backdrop-filter: blur(2px);
        }

        /* Table Responsive Wrapper */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            margin-bottom: 1rem;
        }
        
        /* Prevent body scroll issues */
        img, video, input, select, textarea {
            max-width: 100%;
        }

        @media (max-width: 768px) {
            body {
                overflow-x: hidden;
            }
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease-in-out;
                box-shadow: 2px 0 10px rgba(0,0,0,0.5);
                z-index: 1000;
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .sidebar-overlay.active {
                display: block;
            }
            .main-content {
                margin-left: 0;
                padding: 0.75rem; /* Reduced padding for more space */
                padding-top: 5rem;
                width: 100%;
                box-sizing: border-box;
                overflow-x: hidden;
            }
            .mobile-toggle {
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            /* Responsive Tables */
            .card {
                padding: 1rem;
                overflow: hidden; /* Prevent card expansion */
            }
            
            /* Stats Grid */
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            /* Form adjustments */
            .commission-row {
                flex-direction: column;
                align-items: stretch;
            }
            .input-group {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <button class="mobile-toggle" id="sidebarToggle">
        <i data-lucide="menu"></i>
    </button>
    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const toggle = document.getElementById('sidebarToggle');
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            
            function toggleSidebar() {
                sidebar.classList.toggle('active');
                overlay.classList.toggle('active');
            }
            
            if(toggle) {
                toggle.addEventListener('click', toggleSidebar);
            }
            
            if(overlay) {
                overlay.addEventListener('click', toggleSidebar);
            }
            
            // Close sidebar when clicking a link on mobile
            if(sidebar) {
                const links = sidebar.querySelectorAll('a');
                links.forEach(link => {
                    link.addEventListener('click', () => {
                        if (window.innerWidth <= 768) {
                            toggleSidebar();
                        }
                    });
                });
            }
        });
    </script>

    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h2>Admin Panel</h2>
        </div>
        <ul class="sidebar-menu">
            <li><a href="index.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'index.php' ? 'active' : ''; ?>"><i data-lucide="layout-dashboard"></i> Dashboard</a></li>
            <li><a href="users.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'users.php' ? 'active' : ''; ?>"><i data-lucide="users"></i> Usuários</a></li>
            <li><a href="deposits.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'deposits.php' ? 'active' : ''; ?>"><i data-lucide="arrow-down-circle"></i> Depósitos</a></li>
            <li><a href="withdrawals.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'withdrawals.php' ? 'active' : ''; ?>"><i data-lucide="arrow-up-circle"></i> Saques</a></li>
            <li><a href="game_history.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'game_history.php' ? 'active' : ''; ?>"><i data-lucide="history"></i> Histórico Jogos</a></li>
            <li><a href="gateway.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'gateway.php' ? 'active' : ''; ?>"><i data-lucide="credit-card"></i> Gateway</a></li>
            <li><a href="settings.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'settings.php' ? 'active' : ''; ?>"><i data-lucide="settings"></i> Configurações</a></li>
            <li><a href="logout.php"><i data-lucide="log-out"></i> Sair</a></li>
        </ul>
    </div>
    <div class="main-content">
