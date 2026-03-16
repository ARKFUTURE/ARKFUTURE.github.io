"""
IRC 页面侦察脚本 — 截图 + 收集关键 DOM 信息
"""
from playwright.sync_api import sync_playwright
import json, pathlib

URL = "file:///e:/ARKFUTURE.github.io/res/irc.html"
OUT = pathlib.Path("e:/ARKFUTURE.github.io/tests")
OUT.mkdir(exist_ok=True)

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page(viewport={"width": 1280, "height": 800})
    page.goto(URL)
    page.wait_for_load_state("networkidle")

    # 截图初始状态
    page.screenshot(path=str(OUT / "01_initial.png"), full_page=True)
    print("[OK] 截图 01_initial.png")

    # 收集所有 button / id 属性
    buttons = page.evaluate("""() => {
        return [...document.querySelectorAll('button,[id]')].map(el => ({
            tag: el.tagName,
            id: el.id || null,
            cls: el.className || null,
            text: el.textContent?.trim().slice(0,40) || null,
            visible: el.offsetParent !== null
        }));
    }""")
    print(f"[INFO] 找到 {len(buttons)} 个元素:")
    for b in buttons[:60]:
        print(f"  <{b['tag']}> id={b['id']} cls={b['cls'][:30] if b['cls'] else ''!r} text={b['text']!r} visible={b['visible']}")

    # console 日志
    errors = []
    page.on("console", lambda msg: errors.append(f"[{msg.type}] {msg.text}") if msg.type in ("error","warning") else None)
    page.wait_for_timeout(500)
    if errors:
        print("\n[CONSOLE 错误/警告]")
        for e in errors:
            print(" ", e)
    else:
        print("\n[CONSOLE] 无错误")

    browser.close()
    print("\n侦察完成。")
