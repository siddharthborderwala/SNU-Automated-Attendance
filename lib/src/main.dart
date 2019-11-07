import 'package:puppeteer/puppeteer.dart';

final netID = 'sb943';
final password = 'Sid@9426944582';

void main() async {
  final root_url =
      'https://markattendance.webapps.snu.edu.in/public/application/login/login';

  print('program started');

  var browser = await puppeteer.launch(headless: true);

  var page = await browser.newPage();

  await page.goto(root_url);

  await page.type('input[id="login_user_name"]', netID);

  await page.type('input[id="login_password"]', password);

  await Future.wait([
    page.waitForNavigation(),
    page.click('button[class="btn btn-block btn-primary"]'),
  ]);

  await Future.wait([
    page.waitForNavigation(),
    page.click('a[href="/public/application/index/index"]'),
  ]);

  if ((await page.url) ==
      'https://markattendance.webapps.snu.edu.in/public/application/index/summary') {
    print("Attendance not initiallized\nTry again later.");
    await browser.close();
  } else {
    await page.click('button[class="btn btn-success btn-block"]');
    print("Attendance Successfully Marked");
    await browser.close();
  }
}
