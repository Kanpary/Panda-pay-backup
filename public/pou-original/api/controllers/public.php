<?php
declare(strict_types=1);

function public_game_settings(PDO $pdo): void
{
    $stmt = $pdo->query('SELECT id,difficulty,difficulty_per_level,coin_return,game_speed,jump_height,game_title,game_subtitle,
                                login_banner_url,register_banner_url,rtp_global,coin_frequency,spring_frequency,spring_boost,
                                moving_platform_speed_multiplier,progressive_distance_multiplier,difficulty_rtp_balance,
                                common_player_coin_percentage
                         FROM game_settings ORDER BY updated_at DESC LIMIT 1');
    $settings = $stmt->fetch();
    if (!$settings) json_error('Game settings not found', 404);

    $characterStmt = $pdo->query('SELECT character_name,character_image_url,bg_music_url,bg_music_enabled,
                                         jump_sound_url,land_sound_url,spring_sound_url,coin_sound_url
                                  FROM character_settings
                                  ORDER BY updated_at DESC
                                  LIMIT 1');
    $character = $characterStmt->fetch();

    if ($character) {
        $settings['character'] = [
            'name' => $character['character_name'] ?? '',
            'character_name' => $character['character_name'] ?? '',
            'image_url' => $character['character_image_url'] ?? null,
            'character_image_url' => $character['character_image_url'] ?? null,
            'bg_music_url' => $character['bg_music_url'] ?? null,
            'bg_music_enabled' => isset($character['bg_music_enabled']) ? (int)$character['bg_music_enabled'] === 1 : false,
            'jump_sound_url' => $character['jump_sound_url'] ?? null,
            'land_sound_url' => $character['land_sound_url'] ?? null,
            'spring_sound_url' => $character['spring_sound_url'] ?? null,
            'coin_sound_url' => $character['coin_sound_url'] ?? null,
        ];
    }
    $settings['title'] = $settings['game_title'] ?? '';
    $settings['subtitle'] = $settings['game_subtitle'] ?? '';

    json_success($settings);
}

function public_banners(PDO $pdo): void
{
    $stmt = $pdo->query("SELECT id,title,image_url,placement,is_active,sort_order,created_at,updated_at
                         FROM banners
                         WHERE is_active = 1
                         ORDER BY sort_order ASC, created_at DESC");
    json_success([
        'items' => $stmt->fetchAll(),
    ]);
}

function public_financial_settings(PDO $pdo): void
{
    $stmt = $pdo->query('SELECT id,min_deposit,min_withdrawal_player,min_withdrawal_affiliate,withdrawal_fee_percent,withdrawal_fee_fixed,pix_enabled,updated_at
                         FROM financial_settings
                         ORDER BY updated_at DESC
                         LIMIT 1');
    $settings = $stmt->fetch();
    if (!$settings) {
        json_error('Financial settings not found', 404);
    }
    json_success($settings);
}
