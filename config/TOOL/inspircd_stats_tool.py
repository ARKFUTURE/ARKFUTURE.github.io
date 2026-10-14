#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import base64
import json
import socket
import ssl
import sys
import urllib.error
import urllib.request
import xml.etree.ElementTree as ET
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

HTML_PAGE = r"""<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="color-scheme" content="dark">
<title>IRC</title>
<style>
:root{
  --bg:#04060d;
  --panel:rgba(9,15,28,.82); --panel2:rgba(6,10,20,.9);
  --line:rgba(0,234,255,.18); --line2:rgba(0,234,255,.38);
  --cy:#00eaff; --mg:#ff2bd6; --yl:#ffd400; --gr:#2bff88; --rd:#ff3b5c;
  --text:#d6f4ff; --dim:#5f7d95; --dim2:#8fb3c9;
  --mono:"Cascadia Mono",Consolas,"Courier New",ui-monospace,Menlo,monospace;
}
*{box-sizing:border-box}
html{-webkit-text-size-adjust:100%}
body{margin:0;background:var(--bg);color:var(--text);font:13px/1.6 var(--mono);
  background-image:
    radial-gradient(1100px 600px at 12% -10%,rgba(0,234,255,.10),transparent 60%),
    radial-gradient(900px 500px at 92% 4%,rgba(255,43,214,.09),transparent 62%),
    linear-gradient(rgba(0,234,255,.032) 1px,transparent 1px),
    linear-gradient(90deg,rgba(0,234,255,.032) 1px,transparent 1px);
  background-size:auto,auto,44px 44px,44px 44px;background-attachment:fixed}
body::after{content:"";position:fixed;inset:0;z-index:9999;pointer-events:none;
  background:repeating-linear-gradient(0deg,rgba(0,0,0,.20) 0 1px,transparent 1px 3px);
  mix-blend-mode:multiply;opacity:.45}
::selection{background:rgba(0,234,255,.3);color:#fff}
.num{font-variant-numeric:tabular-nums}
.dim{color:var(--dim)}
.hidden{display:none!important}
.wrap{max-width:1400px;margin:0 auto;padding:0 18px 70px}
header{position:sticky;top:0;z-index:60;background:rgba(4,6,13,.93);backdrop-filter:blur(8px);
  border-bottom:1px solid var(--line);box-shadow:0 8px 30px rgba(0,0,0,.6)}
.hbar{max-width:1400px;margin:0 auto;padding:11px 18px;display:flex;align-items:center;gap:16px;flex-wrap:wrap}
.brand{font-size:16px;font-weight:700;letter-spacing:2px;white-space:nowrap;color:#eafcff;
  text-shadow:0 0 12px rgba(0,234,255,.5)}
.brand .sl{color:var(--cy)}.brand .mgx{color:var(--mg)}
.upd{font-size:12px;color:var(--dim2);letter-spacing:.5px;white-space:nowrap}
.upd b{color:var(--cy);font-weight:600;text-shadow:0 0 8px rgba(0,234,255,.4)}
.upd .tick{display:inline-block;width:6px;height:6px;border-radius:50%;background:var(--gr);
  box-shadow:0 0 8px var(--gr);margin-right:6px;vertical-align:middle;animation:blink 2.4s infinite}
@keyframes blink{0%,88%{opacity:1}94%{opacity:.2}100%{opacity:1}}
.actions{margin-left:auto;display:flex;gap:8px;align-items:center}
button,select,input{font-family:var(--mono);font-size:12px;background:rgba(8,14,26,.9);color:var(--text);
  border:1px solid var(--line);border-radius:2px;padding:6px 12px;outline:none;transition:.15s}
button{cursor:pointer;letter-spacing:1px;text-transform:uppercase}
button:hover,select:hover{border-color:var(--cy);color:var(--cy);box-shadow:0 0 14px rgba(0,234,255,.22)}
button.primary{background:linear-gradient(135deg,rgba(0,234,255,.16),rgba(255,43,214,.16));border-color:var(--cy);color:#eafcff}
button.primary:hover{background:linear-gradient(135deg,rgba(0,234,255,.32),rgba(255,43,214,.28));box-shadow:0 0 18px rgba(0,234,255,.35)}
input:focus,select:focus{border-color:var(--cy);box-shadow:0 0 14px rgba(0,234,255,.2)}
::placeholder{color:#3f5a70}
.banner{margin:14px 0 0;padding:10px 14px;font-size:12px;border:1px solid rgba(255,59,92,.5);
  background:rgba(255,59,92,.08);color:var(--rd);box-shadow:0 0 18px rgba(255,59,92,.15)}
.strip{display:flex;gap:8px;flex-wrap:wrap;align-items:center;margin:16px 0 14px}
.chip{background:var(--panel);border:1px solid var(--line);padding:3px 11px;font-size:11.5px;color:var(--dim)}
.chip b{color:var(--text);font-weight:600}
.chip.v{border-color:rgba(0,234,255,.45);color:var(--cy)}
.chip.m{border-color:rgba(255,43,214,.4);color:var(--mg)}
.cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(155px,1fr));gap:11px;margin-bottom:14px}
.card{position:relative;background:linear-gradient(160deg,var(--panel),var(--panel2));border:1px solid var(--line);
  padding:12px 14px;overflow:hidden;transition:.15s;
  clip-path:polygon(0 0,100% 0,100% calc(100% - 9px),calc(100% - 9px) 100%,0 100%)}
.card:hover{border-color:var(--line2);box-shadow:0 0 20px rgba(0,234,255,.14)}
.card::before{content:"";position:absolute;left:0;top:0;width:2px;height:100%;background:linear-gradient(180deg,var(--cy),transparent)}
.card .label{font-size:10px;color:var(--dim);letter-spacing:2px;text-transform:uppercase}
.card .value{font-size:24px;font-weight:700;margin-top:3px;font-variant-numeric:tabular-nums;color:#eafcff;
  text-shadow:0 0 14px rgba(0,234,255,.35)}
.card .sub{font-size:10.5px;color:var(--dim);margin-top:2px}
.card .bar{height:3px;background:rgba(0,234,255,.12);margin-top:7px;overflow:hidden}
.card .bar i{display:block;height:100%;background:linear-gradient(90deg,var(--cy),var(--mg));box-shadow:0 0 8px var(--cy)}
.panel{background:linear-gradient(160deg,var(--panel),var(--panel2));border:1px solid var(--line);
  padding:14px 16px;margin-bottom:14px;
  clip-path:polygon(0 0,100% 0,100% calc(100% - 12px),calc(100% - 12px) 100%,0 100%)}
.panel h3{margin:0 0 12px;font-size:12px;font-weight:700;letter-spacing:2px;text-transform:uppercase;
  display:flex;align-items:center;gap:8px;color:#eafcff}
.panel h3::before{content:"";width:3px;height:13px;background:var(--cy);box-shadow:0 0 10px var(--cy)}
.panel h3 .n{font-size:10.5px;color:var(--dim);letter-spacing:1px;font-weight:400;border:1px solid var(--line);padding:0 7px}
.grid2{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.grid3{display:grid;grid-template-columns:1fr 1fr 1fr;gap:14px}
@media(max-width:1000px){.grid2,.grid3{grid-template-columns:1fr}}
.tabs{display:flex;gap:6px;flex-wrap:wrap;margin:0 0 14px;border-bottom:1px solid var(--line);padding-bottom:10px}
.tab{background:transparent;border:1px solid var(--line);color:var(--dim);padding:6px 14px;font-size:11.5px;
  letter-spacing:1.5px;text-transform:uppercase;cursor:pointer;transition:.15s}
.tab:hover{color:var(--cy);border-color:var(--line2)}
.tab.on{color:#04060d;background:var(--cy);border-color:var(--cy);font-weight:700;box-shadow:0 0 18px rgba(0,234,255,.4)}
.tab .c{opacity:.75;margin-left:5px;font-size:10px}
.tablewrap{overflow-x:auto}
table{width:100%;border-collapse:collapse;font-size:12px}
th{color:var(--dim);font-weight:600;font-size:10.5px;text-transform:uppercase;letter-spacing:1.2px;
  text-align:left;padding:6px 9px;border-bottom:1px solid var(--line2);white-space:nowrap}
td{padding:6px 9px;border-bottom:1px solid rgba(0,234,255,.07);vertical-align:top}
tbody tr:hover{background:rgba(0,234,255,.06)}
tr.det td{background:rgba(0,234,255,.04);color:var(--dim2)}
td.nick{font-weight:700;color:var(--cy);white-space:nowrap;text-shadow:0 0 8px rgba(0,234,255,.3)}
td.any{word-break:break-all;max-width:340px}
td.clickable{cursor:pointer}
.badge{display:inline-block;padding:0 7px;font-size:10.5px;line-height:19px;white-space:nowrap;letter-spacing:.5px}
.badge.oper{background:rgba(255,43,214,.14);color:var(--mg);border:1px solid rgba(255,43,214,.4)}
.badge.svc{background:rgba(95,125,149,.12);color:var(--dim2);border:1px solid var(--line)}
.badge.away{background:rgba(255,212,0,.12);color:var(--yl);border:1px solid rgba(255,212,0,.35)}
.xl{display:inline-block;min-width:46px;text-align:center;padding:0 6px;font-size:10.5px;font-weight:700;
  line-height:19px;letter-spacing:1px}
.xl-Z{background:rgba(255,59,92,.16);color:var(--rd);border:1px solid rgba(255,59,92,.4)}
.xl-Q{background:rgba(255,212,0,.12);color:var(--yl);border:1px solid rgba(255,212,0,.3)}
.xl-K{background:rgba(255,43,214,.14);color:var(--mg);border:1px solid rgba(255,43,214,.35)}
.xl-E,.xl-G,.xl-R{background:rgba(0,234,255,.12);color:var(--cy);border:1px solid rgba(0,234,255,.3)}
.priv{font-weight:700;margin-right:2px}
.priv.p\@{color:var(--rd)}.priv.p\%{color:var(--yl)}.priv.p\+{color:var(--cy)}
.priv.p\~{color:var(--mg)}.priv.p\&{color:var(--gr)}.priv.p\!{color:var(--yl)}
.kv{display:grid;grid-template-columns:132px 1fr;gap:5px 12px;font-size:11.5px;margin:2px 0 8px}
.kv dt{color:var(--dim);letter-spacing:1px;text-transform:uppercase;font-size:10.5px}
.kv dd{margin:0;word-break:break-all;color:var(--dim2)}
.empty{color:var(--dim);text-align:center;padding:16px 0;font-size:12px;letter-spacing:1px}
.sparkhead{display:flex;align-items:baseline;justify-content:space-between;margin-bottom:4px}
.sparknow{font-size:24px;font-weight:700;color:var(--cy);font-variant-numeric:tabular-nums;
  text-shadow:0 0 14px rgba(0,234,255,.4)}
.sparklegend{font-size:10.5px;color:var(--dim);letter-spacing:1px}
#spark svg{width:100%;height:120px;display:block}
.barrow{display:grid;grid-template-columns:96px 1fr 56px;gap:10px;align-items:center;padding:2px 0}
.barlabel{font-size:11.5px;color:var(--dim);overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.bartrack{background:rgba(0,234,255,.08);height:9px;overflow:hidden}
.bar{height:100%;background:linear-gradient(90deg,var(--cy),var(--mg));min-width:2px;transition:width .35s;
  box-shadow:0 0 8px rgba(0,234,255,.5)}
.barnum{font-size:11.5px;color:var(--dim2);text-align:right;font-variant-numeric:tabular-nums}
.modgrid{display:flex;flex-wrap:wrap;gap:6px;max-height:420px;overflow-y:auto}
.modtag{font-size:11.5px;color:var(--dim2);background:rgba(8,14,26,.8);border:1px solid var(--line);
  padding:2px 8px;cursor:default}
.modtag:hover{color:var(--cy);border-color:var(--line2);box-shadow:0 0 12px rgba(0,234,255,.2)}
.modgroup{margin-bottom:10px}
.modgroup .gt{font-size:10.5px;letter-spacing:2px;text-transform:uppercase;color:var(--mg);margin:0 0 6px}
.searchrow{display:flex;gap:8px;align-items:center;margin-bottom:10px}
.searchrow input{flex:1;max-width:280px}
::-webkit-scrollbar{width:9px;height:9px}
::-webkit-scrollbar-track{background:rgba(0,234,255,.04)}
::-webkit-scrollbar-thumb{background:rgba(0,234,255,.22)}
::-webkit-scrollbar-thumb:hover{background:rgba(0,234,255,.4)}
</style>
</head>
<body>
<header>
  <div class="hbar">
    <div class="brand"><span class="sl">//</span> ARKFUTURE <span class="mgx">IRC</span> NEXUS</div>
    <div class="upd"><span class="tick"></span>更新于 <b id="lastUpdate">--:--:--</b></div>
    <div class="actions">
      <select id="intervalSel" title="刷新间隔">
        <option value="2">2s</option><option value="5" selected>5s</option>
        <option value="10">10s</option><option value="30">30s</option><option value="60">60s</option>
      </select>
      <button id="refreshBtn" class="primary">刷新</button>
    </div>
  </div>
</header>

<div class="wrap">
  <div id="errBanner" class="banner hidden"></div>
  <div id="strip" class="strip"></div>
  <div class="tabs" id="tabs">
    <button class="tab on" data-t="ov">总览</button>
    <button class="tab" data-t="us">用户 <span class="c" id="tabUs">0</span></button>
    <button class="tab" data-t="ch">频道 <span class="c" id="tabCh">0</span></button>
    <button class="tab" data-t="sv">服务器 <span class="c" id="tabSv">0</span></button>
    <button class="tab" data-t="xl">X-Lines <span class="c" id="tabXl">0</span></button>
    <button class="tab" data-t="md">模块 <span class="c" id="tabMd">0</span></button>
    <button class="tab" data-t="cm">命令 <span class="c" id="tabCm">0</span></button>
    <button class="tab" data-t="is">ISUPPORT <span class="c" id="tabIs">0</span></button>
  </div>

  <section id="p-ov">
    <div id="cards" class="cards"></div>
    <div class="grid2">
      <div class="panel">
        <h3>用户数趋势 <span class="n" id="sparkLegend">等待采样</span></h3>
        <div class="sparkhead"><span class="sparknow num" id="sparkNow">-</span></div>
        <div id="spark"></div>
      </div>
      <div class="panel">
        <h3>命令调用 TOP 10</h3>
        <div id="cmdbars"></div>
      </div>
    </div>
    <div class="grid3">
      <div class="panel"><h3>X-LINE 类型分布</h3><div id="xldist"></div></div>
      <div class="panel"><h3>服务器链路负载</h3><div id="srvload"></div></div>
      <div class="panel"><h3>频道概览 <span class="n" id="ovChan">0</span></h3><div id="ovchans"></div></div>
    </div>
    <div class="grid3">
      <div class="panel"><h3>用户身份构成</h3><div id="dvIdent"></div></div>
      <div class="panel"><h3>连接类别与端口</h3><div id="dvConn"></div></div>
      <div class="panel"><h3>节点分布</h3><div id="dvNode"></div></div>
    </div>
  </section>

  <section id="p-us" class="hidden">
    <div class="panel">
      <h3>在线用户 <span class="n" id="usCount">0</span></h3>
      <div class="searchrow">
        <input id="usSearch" type="text" placeholder="过滤:昵称 / 主机 / IP / 身份">
        <span class="dim" id="usHint"></span>
      </div>
      <div class="tablewrap"><table id="usTable"></table></div>
    </div>
  </section>

  <section id="p-ch" class="hidden">
    <div class="panel">
      <h3>频道 <span class="n" id="chCount">0</span></h3>
      <div class="tablewrap"><table id="chTable"></table></div>
    </div>
  </section>

  <section id="p-sv" class="hidden">
    <div class="panel">
      <h3>服务器链路 <span class="n" id="svCount">0</span></h3>
      <div class="tablewrap"><table id="svTable"></table></div>
    </div>
  </section>

  <section id="p-xl" class="hidden">
    <div class="panel">
      <h3>X-LINES <span class="n" id="xlCount">0</span></h3>
      <div class="searchrow">
        <input id="xlSearch" type="text" placeholder="过滤:掩码 / 原因">
        <span class="dim" id="xlHint"></span>
      </div>
      <div class="tablewrap"><table id="xlTable"></table></div>
    </div>
  </section>

  <section id="p-md" class="hidden">
    <div class="panel">
      <h3>已加载模块 <span class="n" id="mdCount">0</span></h3>
      <div class="searchrow">
        <input id="mdSearch" type="text" placeholder="过滤:模块名 / 说明">
        <span class="dim" id="mdHint"></span>
      </div>
      <div id="modBox" class="modgrid"></div>
    </div>
  </section>

  <section id="p-cm" class="hidden">
    <div class="panel">
      <h3>命令调用统计 <span class="n" id="cmCount">0</span></h3>
      <div class="searchrow">
        <input id="cmSearch" type="text" placeholder="过滤命令名">
        <span class="dim" id="cmHint"></span>
      </div>
      <div class="tablewrap"><table id="cmTable"></table></div>
    </div>
  </section>

  <section id="p-is" class="hidden">
    <div class="panel">
      <h3>ISUPPORT 能力令牌 <span class="n" id="isCount">0</span></h3>
      <div class="searchrow">
        <input id="isSearch" type="text" placeholder="过滤令牌">
        <span class="dim" id="isHint"></span>
      </div>
      <div class="tablewrap"><table id="isTable"></table></div>
    </div>
  </section>
</div>

<script>
"use strict";
var $ = function(s){ return document.querySelector(s); };
var DATA = null, HIST = [], TAB = "ov", INTERVAL = 5, TIMER = null;

function asArray(v){ if(v == null) return []; return Array.isArray(v) ? v : [v]; }
function int(v){ var n = parseInt(v, 10); return isNaN(n) ? 0 : n; }
function esc(s){
  return String(s == null ? "" : s).replace(/[&<>"']/g, function(c){
    return {"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]; });
}
function fmtNum(n){ return int(n).toLocaleString("en-US"); }
function pad(n){ return String(n).length < 2 ? "0" + n : String(n); }
function fmtTime(ts){
  if(!int(ts)) return "-";
  var d = new Date(int(ts) * 1000);
  return d.getFullYear() + "-" + pad(d.getMonth()+1) + "-" + pad(d.getDate()) + " " +
         pad(d.getHours()) + ":" + pad(d.getMinutes()) + ":" + pad(d.getSeconds());
}
function fmtClock(ts){
  if(!int(ts)) return "-";
  var d = new Date(int(ts) * 1000);
  return pad(d.getHours()) + ":" + pad(d.getMinutes()) + ":" + pad(d.getSeconds());
}
function fmtDur(sec){
  sec = int(sec);
  if(sec <= 0) return "永久";
  var d = Math.floor(sec/86400), h = Math.floor(sec%86400/3600), m = Math.floor(sec%3600/60), s = sec%60;
  if(d) return d + "天" + h + "小时";
  if(h) return h + "小时" + m + "分";
  if(m) return m + "分";
  return s + "秒";
}
function metaMap(m){
  var out = {};
  if(!m || typeof m !== "object") return out;
  asArray(m.meta).forEach(function(x){
    if(x && typeof x === "object" && x.name) out[x.name] = x.value || "";
  });
  return out;
}

function fetchData(){
  fetch("/api/stats", {method:"POST", headers:{"Content-Type":"application/json"}, body:"{}"})
    .then(function(r){ return r.json().catch(function(){ return {error:"响应不是合法 JSON"}; }); })
    .then(function(d){
      if(d.error) throw new Error(d.error);
      $("#errBanner").classList.add("hidden");
      DATA = d;
      render(d);
      $("#lastUpdate").textContent = new Date().toLocaleTimeString("zh-CN", {hour12:false});
    })
    .catch(function(e){
      var b = $("#errBanner");
      b.textContent = "链路异常:" + e.message + "  //  检查 py 文件顶部内嵌的 SERVER_URL / SERVER_USER / SERVER_PASSWORD";
      b.classList.remove("hidden");
      $("#lastUpdate").textContent = new Date().toLocaleTimeString("zh-CN", {hour12:false});
    });
}
function restartTimer(){
  if(TIMER) clearInterval(TIMER);
  TIMER = setInterval(fetchData, Math.max(2, INTERVAL) * 1000);
}

function render(d){
  var g = d.general || {}, s = d.server || {};
  var mods = asArray(d.modulelist && d.modulelist.module);
  var srvs = asArray(d.serverlist && d.serverlist.server);
  var xs = asArray(d.xlines && d.xlines.xline);
  var cmds = asArray(d.commandlist && d.commandlist.command);
  var toks = asArray(g.isupport && g.isupport.token);
  var users = asArray(d.userlist && d.userlist.user);
  var chans = asArray(d.channellist && d.channellist.channel);
  var uptime = fmtDur(int(g.currenttime) - int(g.boottime));

  $("#strip").innerHTML =
    '<span class="chip v">SERVER <b>' + esc(s.name || "?") + "</b></span>" +
    '<span class="chip">ID <b>' + esc(s.id || "-") + "</b></span>" +
    '<span class="chip">' + esc(s.description || "") + "</span>" +
    '<span class="chip m">' + esc(s.version || "") + (s.customversion ? " / " + esc(s.customversion) : "") + "</span>" +
    '<span class="chip">节点 <b class="num">' + srvs.length + "</b></span>" +
    '<span class="chip">模块 <b class="num">' + mods.length + "</b></span>" +
    '<span class="chip">X-LINE <b class="num">' + xs.length + "</b></span>" +
    '<span class="chip">运行时长 <b>' + uptime + "</b></span>" +
    '<span class="chip">服务器时间 <b class="num">' + fmtTime(int(g.currenttime)) + "</b></span>";

  var sockUsed = int(g.socketcount), sockMax = int(g.socketmax);
  var pct = sockMax > 0 ? Math.min(100, sockUsed / sockMax * 100) : 0;
  var cards = [
    ["总用户", fmtNum(g.usercount), "含服务机器人", -1],
    ["本地用户", fmtNum(g.localusercount), "本机直连", -1],
    ["频道", fmtNum(g.channelcount), "活跃频道", -1],
    ["在线 OPER", fmtNum(g.opercount), "含服务账号", -1],
    ["SOCKET", fmtNum(sockUsed) + " / " + fmtNum(sockMax), "使用率 " + pct.toFixed(3) + "%", pct],
    ["运行时长", uptime, "启动 " + fmtTime(int(g.boottime)), -1],
    ["X-LINES", fmtNum(xs.length), "封禁条目", -1],
    ["模块", fmtNum(mods.length), "已加载", -1]
  ];
  $("#cards").innerHTML = cards.map(function(c){
    return '<div class="card"><div class="label">' + c[0] + '</div><div class="value num">' + c[1] +
      '</div><div class="sub">' + esc(c[2]) + "</div>" +
      (c[3] >= 0 ? '<div class="bar"><i style="width:' + Math.max(pct * 40, 1.5).toFixed(2) + '%"></i></div>' : "") +
      "</div>";
  }).join("");

  $("#tabUs").textContent = users.length;
  $("#tabCh").textContent = chans.length;
  $("#tabSv").textContent = srvs.length;
  $("#tabXl").textContent = xs.length;
  $("#tabMd").textContent = mods.length;
  $("#tabCm").textContent = cmds.length;
  $("#tabIs").textContent = toks.length;

  HIST.push(int(g.usercount));
  if(HIST.length > 90) HIST.shift();
  var chanMap = {};
  chans.forEach(function(c){
    asArray(c.channelmember).forEach(function(m){
      (chanMap[m.uid] = chanMap[m.uid] || []).push({n: c.channelname, p: String(m.privs || "").trim()});
    });
  });

  drawSpark();
  drawCmdBars(cmds);
  drawXlDist(xs);
  drawSrvLoad(srvs);
  drawOvChans(chans, users);
  drawDerived(users, srvs);
  drawUsers(users, g, chanMap);
  drawChans(chans, users);
  drawSrvs(srvs);
  drawXlines(xs, g);
  drawMods(mods);
  drawCmds(cmds);
  drawIsup(toks);
}

function drawSpark(){
  var box = $("#spark"), now = $("#sparkNow"), lg = $("#sparkLegend");
  var v = HIST;
  now.textContent = fmtNum(v[v.length - 1] || 0);
  if(v.length < 2){ lg.textContent = "采样 " + v.length + " / 2"; box.innerHTML = ""; return; }
  var W = 600, H = 120, P = 12;
  var mx = Math.max.apply(null, v), mn = Math.min.apply(null, v), span = Math.max(mx - mn, 1);
  var x = function(i){ return P + (W - 2*P) * i / (v.length - 1); };
  var y = function(t){ return H - P - (H - 2*P) * (t - mn) / span; };
  var pts = v.map(function(t, i){ return x(i).toFixed(1) + "," + y(t).toFixed(1); }).join(" ");
  var last = v.length - 1;
  var grid = "";
  for(var k = 0; k <= 4; k++){
    var gy = (P + (H - 2*P) * k / 4).toFixed(1);
    grid += '<line x1="' + P + '" y1="' + gy + '" x2="' + (W-P) + '" y2="' + gy +
            '" stroke="rgba(0,234,255,.10)" stroke-width="1"/>';
  }
  box.innerHTML =
    '<svg viewBox="0 0 ' + W + " " + H + '" preserveAspectRatio="none">' +
    '<defs><linearGradient id="ag" x1="0" y1="0" x2="0" y2="1">' +
    '<stop offset="0" stop-color="#00eaff" stop-opacity=".38"/>' +
    '<stop offset="1" stop-color="#00eaff" stop-opacity="0"/></linearGradient></defs>' + grid +
    '<path d="M' + x(0).toFixed(1) + "," + (H-P) + " L" + pts.split(" ").join(" L") +
      " L" + x(last).toFixed(1) + "," + (H-P) + ' Z" fill="url(#ag)"/>' +
    '<polyline points="' + pts + '" fill="none" stroke="#00eaff" stroke-width="2" stroke-linejoin="round"/>' +
    '<circle cx="' + x(last).toFixed(1) + '" cy="' + y(v[last]).toFixed(1) + '" r="3.5" fill="#ff2bd6"/>' +
    '<text x="' + P + '" y="' + (P + 2) + '" fill="#5f7d95" font-size="10">MAX ' + mx + "</text>" +
    '<text x="' + P + '" y="' + (H - 2) + '" fill="#5f7d95" font-size="10">MIN ' + mn + "</text>" +
    "</svg>";
  lg.textContent = "采样 " + v.length + " 点";
}
function drawCmdBars(cmds){
  var arr = cmds.map(function(c){ return {n: c.name, v: int(c.usecount)}; })
    .filter(function(a){ return a.v > 0; })
    .sort(function(a, b){ return b.v - a.v; }).slice(0, 10);
  var mx = Math.max.apply(null, arr.map(function(a){ return a.v; }).concat([1]));
  $("#cmdbars").innerHTML = arr.length ? arr.map(function(a){
    return '<div class="barrow"><span class="barlabel">' + esc(a.n) + "</span>" +
      '<div class="bartrack"><div class="bar" style="width:' + (a.v / mx * 100).toFixed(1) + '%"></div></div>' +
      '<span class="barnum">' + fmtNum(a.v) + "</span></div>";
  }).join("") : '<div class="empty">无调用记录</div>';
}
function drawXlDist(xs){
  var NAME = {E:"ELINE", G:"GLINE", K:"KLINE", Q:"QLINE", R:"RLINE", Z:"ZLINE"};
  var cnt = {};
  xs.forEach(function(x){ var t = String(x.type || "?").toUpperCase(); cnt[t] = (cnt[t] || 0) + 1; });
  var keys = Object.keys(cnt).sort(function(a, b){ return cnt[b] - cnt[a]; });
  var mx = Math.max.apply(null, keys.map(function(k){ return cnt[k]; }).concat([1]));
  $("#xldist").innerHTML = keys.length ? keys.map(function(k){
    return '<div class="barrow"><span class="barlabel">' + esc(NAME[k] || k) + "</span>" +
      '<div class="bartrack"><div class="bar" style="width:' + (cnt[k] / mx * 100).toFixed(1) + '%"></div></div>' +
      '<span class="barnum">' + cnt[k] + "</span></div>";
  }).join("") : '<div class="empty">无 X-LINE</div>';
}
function drawSrvLoad(srvs){
  var mx = Math.max.apply(null, srvs.map(function(s){ return int(s.usercount); }).concat([1]));
  $("#srvload").innerHTML = srvs.length ? srvs.map(function(s){
    return '<div class="barrow"><span class="barlabel">' + esc(s.servername) + "</span>" +
      '<div class="bartrack"><div class="bar" style="width:' + (int(s.usercount) / mx * 100).toFixed(1) + '%"></div></div>' +
      '<span class="barnum">' + fmtNum(s.usercount) + "</span></div>";
  }).join("") : '<div class="empty">无节点</div>';
}
function drawOvChans(chans, users){
  $("#ovChan").textContent = chans.length;
  var nick = {};
  users.forEach(function(u){ nick[u.uuid] = u.nickname; });
  $("#ovchans").innerHTML = chans.length ? chans.map(function(c){
    var mem = asArray(c.channelmember).map(function(m){
      var n = nick[m.uid] || m.uid, p = String(m.privs || "").trim();
      return p ? '<span class="priv p' + esc(p) + '">' + esc(p) + "</span>" + esc(n) : esc(n);
    }).join(" ");
    return '<div style="padding:3px 0;border-bottom:1px solid rgba(0,234,255,.07)">' +
      '<span class="nick" style="color:#00eaff;font-weight:700">' + esc(c.channelname) + "</span> " +
      '<span class="dim">+' + esc(c.channelmodes || "") + "</span> " +
      '<span class="dim">(' + int(c.usercount) + ")</span><br>" +
      '<span style="color:#8fb3c9;font-size:11.5px">' + (mem || "-") + "</span></div>";
  }).join("") : '<div class="empty">无频道</div>';
}

function countBy(arr, key){
  var m = {};
  arr.forEach(function(x){
    var v = x[key];
    var k = (v == null || v === "") ? "—" : String(v);
    m[k] = (m[k] || 0) + 1;
  });
  return Object.keys(m).sort(function(a, b){ return m[b] - m[a]; })
    .map(function(k){ return [k, m[k]]; });
}
function barBlock(title, items){
  if(!items.length) return "";
  var mx = Math.max.apply(null, items.map(function(a){ return a[1]; }).concat([1]));
  return '<div class="modgroup"><p class="gt">' + esc(title) + "</p>" +
    items.map(function(a){
      return '<div class="barrow"><span class="barlabel">' + esc(a[0]) + "</span>" +
        '<div class="bartrack"><div class="bar" style="width:' + (a[1] / mx * 100).toFixed(1) + '%"></div></div>' +
        '<span class="barnum">' + fmtNum(a[1]) + "</span></div>";
    }).join("") + "</div>";
}
function drawDerived(users, srvs){
  var oper = users.filter(function(u){ return u.opertype && u.opertype !== "service"; }).length;
  var svc = users.filter(function(u){ return u.opertype === "service"; }).length;
  var away = users.filter(function(u){ return u.away; }).length;
  var norm = users.length - oper - svc;
  $("#dvIdent").innerHTML = barBlock("身份构成", [["OPER", oper], ["服务机器人", svc], ["普通用户", norm], ["离开中", away]]);
  $("#dvConn").innerHTML = barBlock("连接类别", countBy(users, "connectclass")) +
                           barBlock("端口", countBy(users, "port"));
  $("#dvNode").innerHTML = barBlock("所在节点", countBy(users, "server")) +
                           barBlock("节点 Oper", srvs.map(function(s){ return [s.servername, int(s.opercount)]; }));
}

function drawUsers(users, g, chanMap){
  $("#usCount").textContent = users.length;
  var q = String(($("#usSearch") || {}).value || "").toLowerCase();
  var rows = users.filter(function(u){
    if(!q) return true;
    var chs = (chanMap[u.uuid] || []).map(function(c){ return c.n; }).join(" ");
    return [u.nickname, u.displayhost, u.realhost, u.ipaddress, u.opertype, u.realname, u.connectclass, chs]
      .join(" ").toLowerCase().indexOf(q) >= 0;
  });
  $("#usHint").textContent = q ? ("匹配 " + rows.length + " / " + users.length) : "";
  var body = rows.map(function(u){
    var md = metaMap(u.metadata);
    var chansOf = chanMap[u.uuid] || [];
    var isSvc = u.opertype === "service";
    var ident = isSvc ? '<span class="badge svc">SERVICE</span>'
      : (u.opertype ? '<span class="badge oper">' + esc(u.opertype) + "</span>" : '<span class="dim">-</span>');
    var away = u.away ? '<span class="badge away" title="' + esc(u.away) + '">AWAY</span>' : '<span class="dim">在线</span>';
    var idle = int(g.currenttime) - int(u.lastmsg);
    var tip = [u.realname || "", u.ipaddress || "", u.realhost || "", u.connectclass || "", md.cloaks || ""].join(" / ");
    var chTxt = chansOf.length ? chansOf.map(function(c){
        return (c.p ? '<span class="priv p' + esc(c.p) + '">' + esc(c.p) + "</span>" : "") + esc(c.n);
      }).join(" ") : '<span class="dim">—</span>';
    return '<tr class="urow" data-id="' + esc(u.uuid) + '">' +
      '<td class="nick clickable">' + esc(u.nickname) + "</td>" +
      "<td>" + ident + "</td>" +
      '<td class="any">' + chTxt + "</td>" +
      '<td title="' + esc(tip) + '">' + esc(u.displayuser || "") + "@" + esc(u.displayhost || "") + "</td>" +
      "<td>" + esc(u.realhost || "-") + "</td>" +
      "<td>" + esc(u.ipaddress || "-") + "</td>" +
      '<td>+' + esc(u.modes || "") + "</td>" +
      "<td>" + away + "</td>" +
      "<td>" + esc(u.server || "-") + "</td>" +
      '<td class="num">' + esc(u.port || "-") + "</td>" +
      "<td>" + esc(u.connectclass || "-") + "</td>" +
      "<td>" + fmtTime(int(u.signon)) + "</td>" +
      '<td class="num">' + (idle >= 0 ? fmtDur(idle) : "-") + "</td></tr>" +
      '<tr class="det hidden" data-det="' + esc(u.uuid) + '"><td colspan="13">' + userDetail(u, md, g, chansOf) + "</td></tr>";
  }).join("");
  $("#usTable").innerHTML =
    "<thead><tr><th>昵称</th><th>身份</th><th>所在频道</th><th>用户@主机</th><th>真实主机</th><th>IP</th>" +
    "<th>模式</th><th>状态</th><th>所在服务器</th><th>端口</th><th>连接类别</th><th>登录时间</th><th>空闲</th></tr></thead>" +
    "<tbody>" + (body || '<tr><td colspan="13" class="empty">无用户</td></tr>') + "</tbody>";
  asArray(document.querySelectorAll(".urow")).forEach(function(tr){
    tr.onclick = function(){
      var d = document.querySelector('[data-det="' + tr.getAttribute("data-id") + '"]');
      if(d) d.classList.toggle("hidden");
    };
  });
}
function userDetail(u, md, g, chansOf){
  var chNames = (chansOf || []).map(function(c){ return (c.p ? c.p : "") + c.n; }).join("  ");
  var items = [
    ["UUID", u.uuid], ["所在频道", chNames], ["真实姓名", u.realname], ["真实用户名", u.realuser],
    ["显示用户名", u.displayuser], ["显示主机", u.displayhost],
    ["服务地址", u.servaddr], ["CLOAK", md.cloaks], ["SSL 证书", md.ssl_cert],
    ["离开消息", u.away ? (u.away + " (at " + fmtTime(int(u.awaytime)) + ")") : "-"],
    ["改昵称时间", fmtTime(int(u.nickchanged))],
    ["最后活动", fmtTime(int(u.lastmsg)) + " (idle " + fmtDur(int(g.currenttime) - int(u.lastmsg)) + ")"],
    ["CAPS", md.caps], ["OPER 类型", u.opertype], ["连接类别", u.connectclass]
  ];
  return '<dl class="kv">' + items.map(function(it){
    return "<dt>" + esc(it[0]) + "</dt><dd>" + (it[1] ? esc(it[1]) : "-") + "</dd>";
  }).join("") + "</dl>";
}

function drawChans(chans, users){
  $("#chCount").textContent = chans.length;
  var nick = {};
  users.forEach(function(u){ nick[u.uuid] = u.nickname; });
  var body = chans.map(function(c){
    var mem = asArray(c.channelmember).map(function(m){
      var n = nick[m.uid] || m.uid, p = String(m.privs || "").trim();
      var mm = String(m.modes || "");
      return (p ? '<span class="priv p' + esc(p) + '">' + esc(p) + "</span>" : "") + esc(n) +
             (mm ? ' <span class="dim">(+' + esc(mm) + ")</span>" : "");
    }).join(" ");
    return '<tr><td class="nick">' + esc(c.channelname) + "</td>" +
      '<td class="num">' + int(c.usercount) + "</td>" +
      "<td>+" + esc(c.channelmodes || "-") + "</td>" +
      '<td class="any">' + (mem || "-") + "</td>" +
      "<td>" + (typeof c.metadata === "string" && c.metadata ? esc(c.metadata) : "-") + "</td></tr>";
  }).join("");
  $("#chTable").innerHTML =
    "<thead><tr><th>频道</th><th>人数</th><th>模式</th><th>成员（含权限与模式）</th><th>METADATA</th></tr></thead>" +
    "<tbody>" + (body || '<tr><td colspan="5" class="empty">无频道</td></tr>') + "</tbody>";
}

function drawSrvs(srvs){
  $("#svCount").textContent = srvs.length;
  var body = srvs.map(function(s){
    var lag = int(s.lagmillisecs);
    var col = lag > 1000 ? "#ff3b5c" : (lag > 200 ? "#ffd400" : "#2bff88");
    return '<tr><td class="nick">' + esc(s.servername) + "</td>" +
      "<td>" + esc(s.parentname || "（根）") + "</td>" +
      "<td>" + esc(s.description || "-") + "</td>" +
      '<td class="num">' + int(s.usercount) + "</td>" +
      '<td class="num">' + int(s.opercount) + "</td>" +
      '<td class="num" style="color:' + col + '">' + lag + " ms</td></tr>";
  }).join("");
  $("#svTable").innerHTML =
    "<thead><tr><th>服务器</th><th>上级</th><th>描述</th><th>用户</th><th>OPER</th><th>延迟</th></tr></thead>" +
    "<tbody>" + (body || '<tr><td colspan="6" class="empty">无节点</td></tr>') + "</tbody>";
}

function drawXlines(xs, g){
  var NAME = {E:"ELINE", G:"GLINE", K:"KLINE", Q:"QLINE", R:"RLINE", Z:"ZLINE"};
  $("#xlCount").textContent = xs.length;
  var q = String(($("#xlSearch") || {}).value || "").toLowerCase();
  var rows = xs.filter(function(x){
    if(!q) return true;
    return (String(x.mask) + " " + String(x.reason) + " " + String(x.type)).toLowerCase().indexOf(q) >= 0;
  });
  $("#xlHint").textContent = q ? ("匹配 " + rows.length + " / " + xs.length) : "";
  var body = rows.map(function(x){
    var t = String(x.type || "?").toUpperCase();
    var dur = int(x.duration);
    var endT = int(x.settime) + dur;
    var left = dur > 0 ? endT - int(g.currenttime) : -1;
    var expTxt = dur > 0 ? (fmtTime(endT) + (left > 0 ? " · 剩 " + fmtDur(left) : " · 已过期")) : "永久";
    var expCol = dur <= 0 ? "#ffd400" : (left > 0 ? "#2bff88" : "#5f7d95");
    return '<tr><td><span class="xl xl-' + esc(t) + '">' + esc(NAME[t] || t) + "</span></td>" +
      '<td class="any">' + esc(x.mask) + "</td>" +
      "<td>" + esc(x.reason || "-") + "</td>" +
      "<td>" + fmtTime(int(x.settime)) + "</td>" +
      "<td>" + fmtDur(dur) + "</td>" +
      '<td style="color:' + expCol + '">' + expTxt + "</td></tr>";
  }).join("");
  $("#xlTable").innerHTML =
    "<thead><tr><th>类型</th><th>掩码</th><th>原因</th><th>设置时间</th><th>时长</th><th>到期 / 剩余</th></tr></thead>" +
    "<tbody>" + (body || '<tr><td colspan="6" class="empty">无 X-LINE</td></tr>') + "</tbody>";
}

function drawMods(mods){
  $("#mdCount").textContent = mods.length;
  var q = String(($("#mdSearch") || {}).value || "").toLowerCase();
  var rows = mods.filter(function(m){
    if(!q) return true;
    return (String(m.name) + " " + String(m.description)).toLowerCase().indexOf(q) >= 0;
  });
  $("#mdHint").textContent = q ? ("匹配 " + rows.length + " / " + mods.length) : "";
  var groups = {core: [], m: [], other: []};
  rows.forEach(function(m){
    var n = String(m.name || "");
    if(n.indexOf("core_") === 0) groups.core.push(m);
    else if(n.indexOf("m_") === 0) groups.m.push(m);
    else groups.other.push(m);
  });
  function blk(title, arr){
    if(!arr.length) return "";
    return '<div class="modgroup"><p class="gt">' + title + " (" + arr.length + ")</p>" +
      arr.map(function(m){
        return '<span class="modtag" title="' + esc(m.description || "") + '">' + esc(m.name) + "</span>";
      }).join("") + "</div>";
  }
  $("#modBox").innerHTML = mods.length
    ? blk("CORE 核心模块", groups.core) + blk("功能扩展模块", groups.m) + blk("其他", groups.other)
    : '<div class="empty">无模块</div>';
}

function drawCmds(cmds){
  $("#cmCount").textContent = cmds.length;
  var q = String(($("#cmSearch") || {}).value || "").toLowerCase();
  var arr = cmds.map(function(c){ return {n: c.name, v: int(c.usecount)}; })
    .sort(function(a, b){ return b.v - a.v; });
  var rows = arr.filter(function(a){ return !q || a.n.toLowerCase().indexOf(q) >= 0; });
  $("#cmHint").textContent = q ? ("匹配 " + rows.length + " / " + arr.length) : ("活跃 " + arr.filter(function(a){ return a.v > 0; }).length);
  var mx = Math.max.apply(null, arr.map(function(a){ return a.v; }).concat([1]));
  var body = rows.map(function(a){
    return '<tr><td class="nick">' + esc(a.n) + "</td>" +
      '<td class="num">' + fmtNum(a.v) + "</td>" +
      '<td><div class="bartrack" style="margin-top:4px"><div class="bar" style="width:' +
        (a.v / mx * 100).toFixed(1) + '%"></div></div></td></tr>';
  }).join("");
  $("#cmTable").innerHTML =
    "<thead><tr><th>命令</th><th>调用次数</th><th>占比</th></tr></thead>" +
    "<tbody>" + (body || '<tr><td colspan="3" class="empty">无命令</td></tr>') + "</tbody>";
}

function drawIsup(toks){
  $("#isCount").textContent = toks.length;
  var q = String(($("#isSearch") || {}).value || "").toLowerCase();
  var rows = toks.filter(function(t){
    return !q || String(t.name).toLowerCase().indexOf(q) >= 0;
  });
  $("#isHint").textContent = q ? ("匹配 " + rows.length + " / " + toks.length) : "";
  var body = rows.map(function(t){
    return '<tr><td class="nick">' + esc(t.name) + '</td><td class="any">' +
      (t.value ? esc(t.value) : '<span class="dim">（无值）</span>') + "</td></tr>";
  }).join("");
  $("#isTable").innerHTML =
    "<thead><tr><th>令牌</th><th>值</th></tr></thead>" +
    "<tbody>" + (body || '<tr><td colspan="2" class="empty">无 ISUPPORT</td></tr>') + "</tbody>";
}

var SECTIONS = {ov:"p-ov", us:"p-us", ch:"p-ch", sv:"p-sv", xl:"p-xl", md:"p-md", cm:"p-cm", is:"p-is"};
asArray(document.querySelectorAll(".tab")).forEach(function(b){
  b.onclick = function(){
    asArray(document.querySelectorAll(".tab")).forEach(function(x){ x.classList.remove("on"); });
    b.classList.add("on");
    Object.keys(SECTIONS).forEach(function(k){
      $("#" + SECTIONS[k]).classList.toggle("hidden", k !== b.getAttribute("data-t"));
    });
  };
});
function bindSearch(id){
  var el = $("#" + id);
  if(!el) return;
  el.oninput = function(){ if(DATA) render(DATA); };
}
["usSearch", "xlSearch", "mdSearch", "cmSearch", "isSearch"].forEach(bindSearch);
$("#refreshBtn").onclick = fetchData;
$("#intervalSel").onchange = function(e){ INTERVAL = int(e.target.value) || 5; restartTimer(); };

fetchData();
restartTimer();
</script>
</body>
</html>
"""

INDEX_HTML = HTML_PAGE.encode("utf-8")
LOCAL_PORT = 6666
FETCH_TIMEOUT = 8
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else LOCAL_PORT
SERVER_URL = "http://127.0.0.1:7654/stats"
SERVER_USER = "arkfutureadmin"
SERVER_PASSWORD = "zomAmcCrUpLOgCCYuZFcCWHohvZv"


def xml_to_obj(elem):
    children = list(elem)
    if not children:
        return (elem.text or "").strip()
    obj = {}
    for child in children:
        value = xml_to_obj(child)
        tag = child.tag
        if tag in obj:
            if isinstance(obj[tag], list):
                obj[tag].append(value)
            else:
                obj[tag] = [obj[tag], value]
        else:
            obj[tag] = value
    return obj


def parse_stats(xml_bytes):
    root = ET.fromstring(xml_bytes.lstrip())
    return xml_to_obj(root)


def fetch_stats(url, user, password):
    req = urllib.request.Request(url, headers={"User-Agent": "irc-stats-dashboard/1.0"})
    if user or password:
        token = base64.b64encode(("%s:%s" % (user, password)).encode("utf-8")).decode("ascii")
        req.add_header("Authorization", "Basic " + token)
    ctx = None
    if url.lower().startswith("https"):
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE
    with urllib.request.urlopen(req, timeout=FETCH_TIMEOUT, context=ctx) as resp:
        return resp.read()


class Handler(BaseHTTPRequestHandler):
    server_version = "IRCStatsDash/1.0"
    protocol_version = "HTTP/1.1"

    def log_message(self, *args):
        pass

    def _send(self, code, body, ctype="application/json; charset=utf-8"):
        if isinstance(body, str):
            body = body.encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def _serve_stats(self):
        try:
            raw = fetch_stats(SERVER_URL, SERVER_USER, SERVER_PASSWORD)
            try:
                data = parse_stats(raw)
            except ET.ParseError:
                head = raw[:200].lstrip().lower()
                if head.startswith(b"<html") or b"<html" in head or b"webblock" in head:
                    raise ValueError("返回的是网页而非 stats XML（地址可能被重定向/拦截,或路径不对）")
                raise ValueError("返回内容不是合法的 InspIRCd stats XML")
            self._send(200, json.dumps(data, ensure_ascii=False))
        except urllib.error.HTTPError as exc:
            msg = "HTTP %s" % exc.code
            if exc.code in (401, 403):
                msg += "（认证失败:请检查用户名/密码,或 httpd_acl 配置）"
            elif exc.code == 404:
                msg += "（路径不存在:确认 stats 路径,通常是 /stats）"
            self._send(502, json.dumps({"error": msg}, ensure_ascii=False))
        except Exception as exc:
            self._send(502, json.dumps({"error": "%s: %s" % (type(exc).__name__, exc)},
                                       ensure_ascii=False))

    def do_GET(self):
        path = self.path.split("?", 1)[0]
        if path in ("/", "/index.html"):
            self._send(200, INDEX_HTML, "text/html; charset=utf-8")
        elif path == "/api/stats":
            self._serve_stats()
        else:
            self._send(404, json.dumps({"error": "not found"}, ensure_ascii=False))

    def do_POST(self):
        path = self.path.split("?", 1)[0]
        if path != "/api/stats":
            self._send(404, json.dumps({"error": "not found"}, ensure_ascii=False))
            return
        length = int(self.headers.get("Content-Length") or 0)
        if length:
            self.rfile.read(length)
        self._serve_stats()


class LocalServer(ThreadingHTTPServer):
    allow_reuse_address = False

    def server_bind(self):
        if hasattr(socket, "SO_EXCLUSIVEADDRUSE"):
            self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_EXCLUSIVEADDRUSE, 1)
        ThreadingHTTPServer.server_bind(self)


def serve(port):
    try:
        server = LocalServer(("0.0.0.0", port), Handler)
    except OSError as exc:
        print("端口 %d 无法绑定:%s" % (port, exc))
        print("请修改文件顶部的 LOCAL_PORT,或用命令行参数指定端口:python irc_stats_dashboard.py 8080")
        return
    print("监控台已启动 (Ctrl+C 停止) %d" % port)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    serve(PORT)
