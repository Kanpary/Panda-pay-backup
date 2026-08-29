<?php
// Onix Pay v2 Helper - https://onixpay.space/docs/
function onixpay_get_config(){
    global $mysqli;
    $res=$mysqli->query('SELECT * FROM `onixpay` WHERE `id`=1 LIMIT 1');
    return $res ? $res->fetch_assoc() : ['client_id'=>'','client_secret'=>'','ativo'=>0,'taxa'=>0];
}
function onixpay_generate_pix($nome,$cpf,$valor,$descricao,$urlnoty=''){
    $cfg=onixpay_get_config();
    if(empty($cfg['client_id'])||empty($cfg['client_secret'])||!$cfg['ativo']) return ['ok'=>false,'msg'=>'Onix Pay desativado'];
    $cpf=preg_replace('/[^0-9]/','',$cpf);
    $params=['client_id'=>$cfg['client_id'],'client_secret'=>$cfg['client_secret'],'nome'=>$nome ?: 'Cliente','cpf'=>$cpf,'valor'=>number_format((float)$valor,2,'.',''),'descricao'=>$descricao,'urlnoty'=>$urlnoty];
    $ch=curl_init('https://onixpay.space/api/v2/pix/qrcode.php');
    curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_POST=>true,CURLOPT_POSTFIELDS=>http_build_query($params),CURLOPT_HTTPHEADER=>['Content-Type: application/x-www-form-urlencoded'],CURLOPT_TIMEOUT=>30,CURLOPT_SSL_VERIFYPEER=>false,CURLOPT_SSL_VERIFYHOST=>false]);
    $resp=curl_exec($ch); $err=curl_error($ch); $code=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
    if($err) return ['ok'=>false,'msg'=>$err];
    $data=json_decode($resp,true);
    if($code===200&&isset($data['statusCode'])&&$data['statusCode']===200&&isset($data['qrcode'])) return ['ok'=>true,'data'=>$data];
    return ['ok'=>false,'msg'=>$data['message'] ?? 'Erro'];
}
function onixpay_payment($nome,$cpf,$valor,$chave_pix,$descricao='',$urlnoty=''){
    $cfg=onixpay_get_config();
    if(empty($cfg['client_id'])||empty($cfg['client_secret'])||!$cfg['ativo']) return ['ok'=>false,'msg'=>'Onix Pay desativado'];
    $cpf=preg_replace('/[^0-9]/','',$cpf);
    $params=['client_id'=>$cfg['client_id'],'client_secret'=>$cfg['client_secret'],'nome'=>$nome ?: 'Cliente','cpf'=>$cpf,'valor'=>number_format((float)$valor,2,'.',''),'chave_pix'=>$chave_pix,'descricao'=>$descricao,'urlnoty'=>$urlnoty];
    $ch=curl_init('https://onixpay.space/api/v2/pix/payment.php');
    curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_POST=>true,CURLOPT_POSTFIELDS=>http_build_query($params),CURLOPT_HTTPHEADER=>['Content-Type: application/x-www-form-urlencoded'],CURLOPT_TIMEOUT=>30,CURLOPT_SSL_VERIFYPEER=>false,CURLOPT_SSL_VERIFYHOST=>false]);
    $resp=curl_exec($ch); $err=curl_error($ch); $code=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
    if($err) return ['ok'=>false,'msg'=>$err];
    $data=json_decode($resp,true);
    if($code===200&&isset($data['statusCode'])&&$data['statusCode']===200) return ['ok'=>true,'data'=>$data];
    return ['ok'=>false,'msg'=>$data['message'] ?? 'Erro'];
}
function onixpay_status($txid){
    $cfg=onixpay_get_config();
    $url='https://onixpay.space/api/v2/pix/status.php?'.http_build_query(['client_id'=>$cfg['client_id'],'client_secret'=>$cfg['client_secret'],'transaction_id'=>$txid]);
    $ch=curl_init($url); curl_setopt($ch,CURLOPT_RETURNTRANSFER,true); $resp=curl_exec($ch); $code=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch);
    $data=json_decode($resp,true);
    if($code===200) return ['ok'=>true,'data'=>$data];
    return ['ok'=>false,'msg'=>$data['message'] ?? 'Erro'];
}