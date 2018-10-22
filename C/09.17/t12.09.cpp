#include <iostream>
using namespace std;


int main() {
	int number, attempt = 0, num = 1, pas = 0, pin, list = 1;
	int room = 1, room1 = 0, cancel = 1, buy, room2 = 0, day = 0, room3 = 0, change = 1;
	int money = 0, money13 = 0, money16 = 0, money18 = 0, day1;
	int eat = 1, eat13 = 0, eat16 = 0, eat18 = 0, eatm13 = 0, eatm16 = 0, eatm18 = 0;

	while (num != 0)
	{
		cout << "Nomreni daxil edin\n";
		do
		{
			cin >> number;
			if (number != 12345)
			{
				cout << "Yalnisdir. Tekrar daxil edin\n";
			}
		} while (number != 12345);

		cout << "Salam IT step oteline zeng etmisiniz.\nSifreni daxil edin\n";
		cin >> pas;
		++attempt;
		while (pas != 12345 && attempt != 3)
		{
			cout << "Yalnisdir tekrar daxil edin\n";
			cout << 3 - attempt << " defe cehd eliye bilersiniz\n";
			cin >> pas;
			++attempt;
		}
		if (pas == 12345) { --attempt; }
		else if (attempt == 3) { cout << "Sagolun\n"; break; }
		cout << "Pini daxil edin\n";
		cin >> pin;
		++attempt;
		while (pin != 1234 && attempt != 3)
		{
			cout << "Yalnisdir tekrar daxil edin\n";
			cout << 3 - attempt << " defe cehd eliye bilersiniz\n";
			cin >> pin;
			++attempt;
		}
		if (attempt == 3) { cout << "Sagolun\n"; break; }
		cout << "Pulunuzun miqdarini daxil edin\n";
		cin >> money;
		while (list != 0)
		{
			cout << "\nNomrelerin siyahisi ile tanis olmaq ucun 1 basin\n";
			cout << "Bos nomrelerin siyahisi ile tanis olmaq ucun 2 basin\n";
			cout << "Bron etmek ve ya almaq ucun 3 basin\n";
			cout << "Bron etdiyiniz nomreni legv etmek ucun 4 basin\n";
			cout << "Nomreni deyismek ucun 5 basin\n";
			cout << "Sohbeti bitirmek ucun 0 basin\n";
			cin >> list;
			num = list;
			if (list == 1)
			{
				cout << "\n11  12  13  14  15  16  17  18  19  20\n";
			}
			else if (list == 2)
			{
				if (room3 == 0)
				{
					cout << "\n13 - 100 manat\n16 - 200 manat\n18 - 400 manat\n";
				}
				else if (room3 == 1)
				{
					cout << "\n16 - 200 manat\n18 - 400 manat\n";
				}
				else if (room3 == 2)
				{
					cout << "\n13 - 100 manat\n18 - 400 manat\n";
				}
				else if (room3 == 3)
				{
					cout << "\n18 - 400 manat\n";
				}
				else if (room3 == 4)
				{
					cout << "\n13 - 100 manat\n16 - 200 manat\n";
				}
				else if (room3 == 5)
				{
					cout << "16 - 200 manat\n";
				}
				else if (room3 == 6)
				{
					cout << "\n13 - 100 manat\n";
				}
				else if (room3 == 7)
				{
					cout << "\nBos nomre yoxdur\n";
				}
			}
			else if (list == 3)
			{
				room = 1;
				while (room != 0)
				{
					eat = 1;
					cout << "Bron etmek ve ya almaq  istediyiniz nomreni daxil edin. bron etdikde nomrenin qiymetinin 50% odemelisiniz.\nGeri qayitmaq ucun 0 daxil edin\n";
					cin >> room;
					if (room == 13)
					{
						if (room1 != 1 && room1 != 3 && room1 != 5 && room2 != 1 && room2 != 3 && room2 != 5 && room1 != 7 && room2 != 7)
						{
							cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
							cin >> buy;
							if (buy == 1 || buy == 2)
							{


								cout << "Nece gunluk ?\n";
								cin >> day;
								day1 = day / 10;
								money13 = 100 * (day - day1);
								if (buy == 1 && money >= money13)
								{

									money = money - money13;
									cout << "Siz 13 nomreli otaqi aldiniz\nPulunuzdan " << money13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

									room2 = room2 + 1;
									room3 = room3 + 1;
									while (eat != 0)
									{
										cout << "1 defe yemek ucun 1 basin (50 manat)\n";
										cout << "2 defe yemek ucun 2 basin (100 manat)\n";
										cout << "3 defe yemek ucun 3 basin (150 manat)\n";
										cout << "Geri qayitmaq ucun 0 basin\n";
										cin >> eat;
										if (eat == 1 && eat13 == 0)
										{
											eatm13 = 50 * day;

											if (eatm13 <= money)
											{
												eat13 = 1;
												money = money - eatm13;
												cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 1 && eat13 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 2 && eat13 == 0)
										{
											eatm13 = 100 * day;

											if (eatm13 <= money)
											{
												eat13 = 2;
												money = money - eatm13;
												cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 2 && eat13 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 3 && eat13 == 0)
										{
											eatm13 = 150 * day;

											if (eatm13 <= money)
											{
												eat13 = 3;
												money = money - eatm13;
												cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 3 && eat13 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}


									}

								}
								else if (buy == 1 && money < money13)
								{
									cout << "Sizin pulunuz azdir\n";
								}
								else if (buy == 2 && money >= money13)
								{

									money = money - (money13 / 2);
									cout << "Siz 13 nomreli otaqi bron etdiniz\nPulunuzdan " << money13 / 2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

									room1 = room1 + 1;
									room3 = room3 + 1;
									while (eat != 0)
									{
										cout << "1 defe yemek ucun 1 basin (50 manat)\n";
										cout << "2 defe yemek ucun 2 basin (100 manat)\n";
										cout << "3 defe yemek ucun 3 basin (150 manat)\n";
										cout << "Geri qayitmaq ucun 0 basin\n";
										cin >> eat;
										if (eat == 1 && eat13 == 0)
										{
											eatm13 = 50 * day;

											if (eatm13 <= money)
											{
												eat13 = 1;
												money = money - eatm13;
												cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 1 && eat13 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 2 && eat13 == 0)
										{
											eatm13 = 100 * day;

											if (eatm13 <= money)
											{
												eat13 = 2;
												money = money - eatm13;
												cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 2 && eat13 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 3 && eat13 == 0)
										{
											eatm13 = 150 * day;

											if (eatm13 <= money)
											{
												eat13 = 3;
												money = money - eatm13;
												cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 3 && eat13 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}


									}

								}
								else if (buy == 2 && money < money13)
								{
									cout << "Sizin pulunuz azdir\n";
								}
								else
								{
									cout << "Duzgun daxil edin\n";
								}
							}
							else
							{
								cout << "Duzgun daxil et\n";
							}

						}
						else
						{
							cout << "Bu nomre doludur\n\n";
						}
					}
					else if (room == 16)
					{
						if (room1 != 2 && room1 != 3 && room1 != 6 && room2 != 2 && room2 != 3 && room2 != 6 && room1 != 7 && room2 != 7)
						{
							cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
							cin >> buy;
							if (buy == 1 || buy == 2)
							{


								cout << "Nece gunluk ?\n";
								cin >> day;
								day1 = day / 10;
								money16 = 200 * (day - day1);
								if (buy == 1 && money >= money16)
								{
									money = money - money16;

									cout << "Siz 16 nomreli otaqi aldiniz\nPulunuzdan " << money16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

									room2 = room2 + 2;
									room3 = room3 + 2;
									while (eat != 0)
									{
										cout << "1 defe yemek ucun 1 basin (50 manat)\n";
										cout << "2 defe yemek ucun 2 basin (100 manat)\n";
										cout << "3 defe yemek ucun 3 basin (150 manat)\n";
										cout << "Geri qayitmaq ucun 0 basin\n";
										cin >> eat;
										if (eat == 1 && eat16 == 0)
										{
											eatm16 = 50 * day;

											if (eatm16 <= money)
											{
												eat16 = 1;
												money = money - eatm16;
												cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 1 && eat16 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 2 && eat16 == 0)
										{
											eatm16 = 100 * day;

											if (eatm16 <= money)
											{
												eat16 = 2;
												money = money - eatm16;
												cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 2 && eat16 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 3 && eat16 == 0)
										{
											eatm16 = 150 * day;

											if (eatm16 <= money)
											{
												eat16 = 3;
												money = money - eatm16;
												cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 3 && eat16 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}


									}


								}
								else if (buy == 1 && money < money16)
								{
									cout << "Sizin pulunuz azdir\n";
								}
								else if (buy == 2 && money >= money16)
								{
									money = money - (money16 / 2);
									cout << "Siz 16 nomreli otaqi bron etdiniz\nPulunuzdan " << money16 / 2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

									room1 = room1 + 2;
									room3 = room3 + 2;
									while (eat != 0)
									{
										cout << "1 defe yemek ucun 1 basin (50 manat)\n";
										cout << "2 defe yemek ucun 2 basin (100 manat)\n";
										cout << "3 defe yemek ucun 3 basin (150 manat)\n";
										cout << "Geri qayitmaq ucun 0 basin\n";
										cin >> eat;
										if (eat == 1 && eat16 == 0)
										{
											eatm16 = 50 * day;

											if (eatm16 <= money)
											{
												eat16 = 1;
												money = money - eatm16;
												cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 1 && eat16 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 2 && eat16 == 0)
										{
											eatm16 = 100 * day;

											if (eatm16 <= money)
											{
												eat16 = 2;
												money = money - eatm16;
												cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 2 && eat16 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 3 && eat16 == 0)
										{
											eatm16 = 150 * day;

											if (eatm16 <= money)
											{
												eat16 = 3;
												money = money - eatm16;
												cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 3 && eat16 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}


									}

								}
								else if (buy == 2 && money < money16)
								{
									cout << "Sizin pulunuz azdir\n";
								}
							}
							else
							{
								cout << "Duzgun daxil edin\n";
							}

						}
						else
						{
							cout << "Bu nomre doludur\n\n";
						}
					}

					else if (room == 18)
					{
						if (room1 != 4 && room1 != 5 && room1 != 6 && room1 != 7 && room2 != 4 && room2 != 5 && room2 != 6 && room2 != 7)
						{
							cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
							cin >> buy;
							if (buy == 1 || buy == 2)
							{


								cout << "Nece gunluk ?\n";
								cin >> day;
								day1 = day / 10;
								money18 = 400 * (day - day1);
								if (buy == 1 && money >= money18)
								{
									money = money - money18;
									cout << "Siz 18 nomreli otaqi aldiniz\nPulunuzdan " << money18 << "manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

									room2 = room2 + 4;
									room3 = room3 + 4;
									while (eat != 0)
									{
										cout << "1 defe yemek ucun 1 basin (50 manat)\n";
										cout << "2 defe yemek ucun 2 basin (100 manat)\n";
										cout << "3 defe yemek ucun 3 basin (150 manat)\n";
										cout << "Geri qayitmaq ucun 0 basin\n";
										cin >> eat;
										if (eat == 1 && eat18 == 0)
										{
											eatm18 = 50 * day;

											if (eatm18 <= money)
											{
												eat18 = 1;
												money = money - eatm18;
												cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 1 && eat18 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 2 && eat18 == 0)
										{
											eatm18 = 100 * day;

											if (eatm18 <= money)
											{
												eat18 = 2;
												money = money - eatm18;
												cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 2 && eat18 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}
										else if (eat == 3 && eat18 == 0)
										{
											eatm18 = 150 * day;

											if (eatm18 <= money)
											{
												eat18 = 3;
												money = money - eatm18;
												cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
												cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											}
											else
											{
												cout << "\nSizin pulunuz azdir\n";
											}

										}
										else if (eat == 3 && eat18 != 0)
										{
											cout << "\nSiz artiq yemek sifaris vermisinz\n";
										}


									}


								}
								else if (buy == 1 && money < money18)
								{
									cout << "Sizin pulunuz azdir\n";
								}
								else if (buy == 2 && money >= money18)

									money = money - (money18 / 2);
								cout << "Siz 18 nomreli otaqi bron etdiniz\nPulunuzdan " << money18 / 2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

								room1 = room1 + 4;
								room3 = room3 + 4;
								while (eat != 0)
								{
									cout << "1 defe yemek ucun 1 basin (50 manat)\n";
									cout << "2 defe yemek ucun 2 basin (100 manat)\n";
									cout << "3 defe yemek ucun 3 basin (150 manat)\n";
									cout << "Geri qayitmaq ucun 0 basin\n";
									cin >> eat;
									if (eat == 1 && eat18 == 0)
									{
										eatm18 = 50 * day;

										if (eatm18 <= money)
										{
											eat18 = 1;
											money = money - eatm18;
											cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
											cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										}
										else
										{
											cout << "\nSizin pulunuz azdir\n";
										}

									}
									else if (eat == 1 && eat18 != 0)
									{
										cout << "\nSiz artiq yemek sifaris vermisinz\n";
									}
									else if (eat == 2 && eat18 == 0)
									{
										eatm18 = 100 * day;

										if (eatm18 <= money)
										{
											eat18 = 2;
											money = money - eatm18;
											cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
											cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										}
										else
										{
											cout << "\nSizin pulunuz azdir\n";
										}

									}
									else if (eat == 2 && eat18 != 0)
									{
										cout << "\nSiz artiq yemek sifaris vermisinz\n";
									}
									else if (eat == 3 && eat18 == 0)
									{
										eatm18 = 150 * day;

										if (eatm18 <= money)
										{
											eat18 = 3;
											money = money - eatm18;
											cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
											cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										}
										else
										{
											cout << "\nSizin pulunuz azdir\n";
										}

									}
									else if (eat == 3 && eat18 != 0)
									{
										cout << "\nSiz artiq yemek sifaris vermisinz\n";
									}


								}
							}
							else
							{
								cout << "Duzgun daxil edin\n";
							}
						}
						else if (buy == 2 && money < money18)
						{
							cout << "Sizin pulunuz azdir\n";
						}
						else
						{
							cout << "Duzgun daxil edin\n";
						}


					}
					else
					{
						cout << "Bu nomre doludur ve ya yoxdur\n\n";
					}
				}


			}



			else if (list == 4)
			{
				cancel = 1;
				while (cancel != 0)
				{
					if (room1 == 0)
					{
						cout << "\nSiz hec bir nomreni bron etmemisinz\n";
						cancel = 0;
					}
					else if (room1 == 1)
					{
						cout << "\nSiz 13 cu nomreni bron etmisiniz\n";
					}
					else if (room1 == 2)
					{
						cout << "\nSiz 16 ci nomreni bron etmisinz\n";
					}
					else if (room1 == 3)
					{
						cout << "\nSiz 13 ve 16 ci nomreni bron etmisiniz\n";
					}
					else if (room1 == 4)
					{
						cout << "\nSiz 18 ci nomreni bron etmisiniz\n";
					}
					else if (room1 == 5)
					{
						cout << "\nSiz 13 ve 18 ci nomreni bron etmisiniz\n";
					}
					else if (room1 == 6)
					{
						cout << "\nSiz 16 ve 18 ci nomreni bron etmisiniz\n";
					}
					else if (room1 == 7)
					{
						cout << "\nSiz 13 , 16 ve 18 ci nomreleri bron etmisiniz\n";
					}

					cout << "Legv etmek istediyiniz nomreni daxil edin\nLegv ederken bron ucun odediyiniz menlegin 50 % qaytarilacaq\nGeri qayitmaq ucun 0 basin\n";
					cin >> cancel;
					if (cancel == 13)
					{
						if (room1 == 1 || room1 == 3 || room1 == 5 || room1 == 7)
						{
							room3 = room3 - 1;
							room1 = room1 - 1;
							eat13 = 0;
							money = money + (money13 - 25);
							money = money + eatm13;
							cout << "\nLegv olundu\n";
							cout << "Pulunuz " << money << " qederdir";
						}
						else if (room1 == 2 || room1 == 4 || room1 == 6)
						{
							cout << "Siz bu nomreni bron etmemisiniz\n";
						}
					}
					else if (cancel == 16)
					{
						if (room1 == 2 || room1 == 3 || room1 == 6 || room1 == 7)
						{
							room3 = room3 - 2;
							room1 = room1 - 2;
							eat16 = 0;
							money = money + (money16 - 50);
							money = money + eatm16;
							cout << "\nLegv olundu\n";
							cout << "Pulunuz " << money16 << " qederdir";
						}
						else if (room1 == 1 || room1 == 4 || room1 == 5)
						{
							cout << "Siz bu nomreni bron etmemisiniz\n";
						}
					}
					else if (cancel == 18)
					{
						if (room1 == 4 || room1 == 5 || room1 == 6 || room1 == 7)
						{
							room3 = room3 - 4;
							room1 = room1 - 4;
							eat18 = 0;
							money = money + (money18 - 100);
							money = money + eatm18;
							cout << "\nLegv olundu\n";
							cout << "Pulunuz " << money18 << " qederdir";
						}
						else if (room1 == 1 || room1 == 2 || room1 == 3)
						{
							cout << "Siz bu nomreni bron etmemisiniz\n";
						}
					}
					else if (cancel != 13 && cancel != 16 && cancel != 18 && cancel != 0)
					{
						cout << "Duzgun secin\n";
					}
				}
			}
			else if (list == 5)
			{
				if (room3 == 1 || room3 == 2 || room3 == 4)
				{

					change = 1;
					while (change != 0)
					{

						if (room2 == 1 || room2 == 2 || room2 == 4)
						{

							if (room2 == 1)
							{
								cout << "Siz 13 cu otagi almisiniz\n";
							}
							else if (room2 == 2)
							{
								cout << "Siz 16 ci otagi almisiniz\n";
							}
							else if (room2 == 4)
							{
								cout << "Siz 18 ci otagi almisinz\n";
							}
							cout << "Legv etmek ucun 1 basin\n";
							cout << "Geri qayitmaq ucun 0 basin\n";
							cin >> change;
							if (change == 1)
							{

								if (room1 == 1)
								{
									money = money + (money13 / 2);
									room1 = 0;
									money = money + eatm13;
									eat13 = 0;
								}
								else if (room2 == 1)
								{
									money = money + money13;
									room2 = 0;
									money = money + eatm13;
									eat13 = 0;



								}
								else if (room1 == 2)
								{
									money = money + (money16 / 2);
									room1 = 0;
									money = money + eatm16;
									eat16 = 0;



								}
								else if (room2 == 2)
								{
									money = money + money16;
									room2 = 0;
									money = money + eatm16;
									eat16 = 0;



								}
								else if (room1 == 4)
								{
									money = money + (money18 / 2);
									room1 = 0;
									money = money + eatm18;
									eat18 = 0;



								}
								else if (room2 == 4)
								{
									money = money + money18;
									room2 = 0;
									money = money + eatm18;
									eat18 = 0;



								}

								cout << "Evvelki nomre legv olundu\n";
								cout << "Sizin pulunuz " << money << "qederdir\n";
								cout << "Goturmey istediyiniz nomreni daxil edin\n";
								cout << "Geri qayitmq ucun 0 basin\n";

								cin >> room;
								change = room;
								room1 = 0;
								room2 = 0;
								room3 = 0;
								if (room == 13)
								{
									if (room1 != 1 && room1 != 3 && room1 != 5 && room2 != 1 && room2 != 3 && room2 != 5 && room1 != 7 && room2 != 7)
									{
										cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
										cin >> buy;
										cout << "Nece gunluk ?\n";
										cin >> day;
										day1 = day / 10;
										money13 = 100 * (day - day1);
										if (buy == 1 && money >= money13)
										{

											money = money - money13;
											cout << "Siz 13 nomreli otaqi aldiniz\nPulunuzdan " << money13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room2 = room2 + 1;
											room3 = room3 + 1;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat13 == 0)
												{
													eatm13 = 50 * day;

													if (eatm13 <= money)
													{
														eat13 = 1;
														money = money - eatm13;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat13 == 0)
												{
													eatm13 = 100 * day;

													if (eatm13 <= money)
													{
														eat13 = 2;
														money = money - eatm13;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat13 == 0)
												{
													eatm13 = 150 * day;

													if (eatm13 <= money)
													{
														eat13 = 3;
														money = money - eatm13;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}


										}
										else if (buy == 1 && money < money13)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else if (buy == 2 && money >= money13)
										{

											money = money - (money13 / 2);
											cout << "Siz 13 nomreli otaqi bron etdiniz\nPulunuzdan " << money13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room1 = room1 + 1;
											room3 = room3 + 1;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat13 == 0)
												{
													eatm13 = 50 * day;

													if (eatm13 <= money)
													{
														eat13 = 1;
														money = money - eatm13;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat13 == 0)
												{
													eatm13 = 100 * day;

													if (eatm13 <= money)
													{
														eat13 = 2;
														money = money - eatm13;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat13 == 0)
												{
													eatm13 = 150 * day;

													if (eatm13 <= money)
													{
														eat13 = 3;
														money = money - eatm13;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}

										}
										else if (buy == 2 && money < money13)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else
										{
											cout << "Duzgun daxil edin\n";
										}
									}
									else
									{
										cout << "Bu nomre doludur\n\n";
									}
								}
								else if (room == 16)
								{
									if (room1 != 2 && room1 != 3 && room1 != 6 && room2 != 2 && room2 != 3 && room2 != 6 && room1 != 7 && room2 != 7)
									{
										cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
										cin >> buy;
										cout << "Nece gunluk ?\n";
										cin >> day;
										day1 = day / 10;
										money16 = 200 * (day - day1);
										if (buy == 1 && money >= money16)
										{
											money = money - money16;

											cout << "Siz 16 nomreli otaqi aldiniz\nPulunuzdan " << money16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room2 = room2 + 2;
											room3 = room3 + 2;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat16 == 0)
												{
													eatm16 = 50 * day;

													if (eatm16 <= money)
													{
														eat16 = 1;
														money = money - eatm16;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat16 == 0)
												{
													eatm16 = 100 * day;

													if (eatm16 <= money)
													{
														eat16 = 2;
														money = money - eatm16;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat16 == 0)
												{
													eatm16 = 150 * day;

													if (eatm16 <= money)
													{
														eat16 = 3;
														money = money - eatm16;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}


										}
										else if (buy == 1 && money < money16)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else if (buy == 2 && money >= money16)
										{

											money = money - (money16 / 2);
											cout << "Siz 16 nomreli otaqi bron etdiniz\nPulunuzdan " << money16 / 2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room1 = room1 + 2;
											room3 = room3 + 2;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat16 == 0)
												{
													eatm16 = 50 * day;

													if (eatm16 <= money)
													{
														eat16 = 1;
														money = money - eatm16;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat16 == 0)
												{
													eatm16 = 100 * day;

													if (eatm16 <= money)
													{
														eat16 = 2;
														money = money - eatm16;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat16 == 0)
												{
													eatm16 = 150 * day;

													if (eatm16 <= money)
													{
														eat16 = 3;
														money = money - eatm16;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}

										}
										else if (buy == 2 && money < money16)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else
										{
											cout << "Duzgun daxil edin\n";
										}

									}
									else
									{
										cout << "Bu nomre doludur\n\n";
									}
								}

								else if (room == 18)
								{
									if (room1 != 4 && room1 != 5 && room1 != 6 && room1 != 7 && room2 != 4 && room2 != 5 && room2 != 6 && room2 != 7)
									{
										cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
										cin >> buy;
										cout << "Nece gunluk ?\n";
										cin >> day;
										day1 = day / 10;
										money18 = 400 * (day - day1);
										if (buy == 1 && money >= money18)
										{
											money = money - money18;
											cout << "Siz 18 nomreli otaqi aldiniz\nPulunuzdan " << money18 << "manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room2 = room2 + 4;
											room3 = room3 + 4;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat18 == 0)
												{
													eatm18 = 50 * day;

													if (eatm18 <= money)
													{
														eat18 = 1;
														money = money - eatm18;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat18 == 0)
												{
													eatm18 = 100 * day;

													if (eatm18 <= money)
													{
														eat18 = 2;
														money = money - eatm18;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat18 == 0)
												{
													eatm18 = 150 * day;

													if (eatm18 <= money)
													{
														eat18 = 3;
														money = money - eatm18;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}


										}
										else if (buy == 1 && money < money18)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else if (buy == 2 && money >= money18)
										{
											money = money - (money18 / 2);
											cout << "Siz 18 nomreli otaqi bron etdiniz\nPulunuzdan " << money18 / 2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room1 = room1 + 4;
											room3 = room3 + 4;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat18 == 0)
												{
													eatm18 = 50 * day;

													if (eatm18 <= money)
													{
														eat18 = 1;
														money = money - eatm18;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat18 == 0)
												{
													eatm18 = 100 * day;

													if (eatm18 <= money)
													{
														eat18 = 2;
														money = money - eatm18;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat18 == 0)
												{
													eatm18 = 150 * day;

													if (eatm18 <= money)
													{
														eat18 = 3;
														money = money - eatm18;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}

										}
										else if (buy == 2 && money < money18)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else
										{
											cout << "Duzgun daxil edin\n";
										}


									}
									else
									{
										cout << "Bu nomre doludur\n\n";
									}
								}
								else
								{
									cout << "Bele otaq yoxdur ve ya doludur\n";
								}
							}

						}
						else if (room1 == 1 || room1 == 2 || room1 == 4)
						{
							if (room1 == 1)
							{
								cout << "Siz 13 cu otagi bron etmisiniz\n";
							}
							else if (room1 == 2)
							{
								cout << "Siz 16 ci otagi bron etmisiniz\n";
							}
							else if (room1 == 4)
							{
								cout << "Siz 18 ci otagi bron etmisiniz\n";
							}
							cout << "Legv etmek ucun 1 basin\n";
							cout << "Geri qayitmaq ucun 0 basin\n";
							cin >> change;
							if (change == 1)
							{
								cout << "Evvelki nomre legv olundu\n";
								cout << "Sizin pulunuz " << money << "qederdir\n";
								cout << "Goturmey istediyiniz nomreni daxil edin\n";
								cout << "Geri qayitmq ucun 0 basin\n";
								cin >> room;
								change = room;
								room1 = 0;
								room3 = 0;

								if (room == 13)
								{
									if (room1 != 1 && room1 != 3 && room1 != 5 && room2 != 1 && room2 != 3 && room2 != 5 && room1 != 7 && room2 != 7)
									{
										cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
										cin >> buy;
										cout << "Nece gunluk ?\n";
										cin >> day;
										day1 = day / 10;
										money13 = 100 * (day - day1);
										if (buy == 1 && money >= money13)
										{

											money = money - money13;
											cout << "Siz 13 nomreli otaqi aldiniz\nPulunuzdan " << money13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room2 = room2 + 1;
											room3 = room3 + 1;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat13 == 0)
												{
													eatm13 = 50 * day;

													if (eatm13 <= money)
													{
														eat13 = 1;
														money = money - eatm13;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat13 == 0)
												{
													eatm13 = 100 * day;

													if (eatm13 <= money)
													{
														eat13 = 2;
														money = money - eatm13;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat13 == 0)
												{
													eatm13 = 150 * day;

													if (eatm13 <= money)
													{
														eat13 = 3;
														money = money - eatm13;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}


										}
										else if (buy == 1 && money < money13)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else if (buy == 2 && money >= money13)
										{

											money = money - (money13 / 2);
											cout << "Siz 13 nomreli otaqi bron etdiniz\nPulunuzdan " << money13 / 2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room1 = room1 + 1;
											room3 = room3 + 1;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat13 == 0)
												{
													eatm13 = 50 * day;

													if (eatm13 <= money)
													{
														eat13 = 1;
														money = money - eatm13;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat13 == 0)
												{
													eatm13 = 100 * day;

													if (eatm13 <= money)
													{
														eat13 = 2;
														money = money - eatm13;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat13 == 0)
												{
													eatm13 = 150 * day;

													if (eatm13 <= money)
													{
														eat13 = 3;
														money = money - eatm13;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm13 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat13 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}

										}
										else if (buy == 2 && money < money13)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else
										{
											cout << "Duzgun daxil edin\n";
										}
									}
									else
									{
										cout << "Bu nomre doludur\n\n";
									}
								}
								else if (room == 16)
								{
									if (room1 != 2 && room1 != 3 && room1 != 6 && room2 != 2 && room2 != 3 && room2 != 6 && room1 != 7 && room2 != 7)
									{
										cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
										cin >> buy;
										cout << "Nece gunluk ?\n";
										cin >> day;
										day1 = day / 10;
										money16 = 200 * (day - day1);
										if (buy == 1 && money >= money16)
										{
											money = money - money16;

											cout << "Siz 16 nomreli otaqi aldiniz\nPulunuzdan " << money16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room2 = room2 + 2;
											room3 = room3 + 2;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat16 == 0)
												{
													eatm16 = 50 * day;

													if (eatm16 <= money)
													{
														eat16 = 1;
														money = money - eatm16;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat16 == 0)
												{
													eatm16 = 100 * day;

													if (eatm16 <= money)
													{
														eat16 = 2;
														money = money - eatm16;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat16 == 0)
												{
													eatm16 = 150 * day;

													if (eatm16 <= money)
													{
														eat16 = 3;
														money = money - eatm16;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}




										}
										else if (buy == 1 && money < money16)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else if (buy == 2 && money >= money16)
										{
											money = money - (money16 / 2);
											cout << "Siz 16 nomreli otaqi bron etdiniz\nPulunuzdan " << money16 / 2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room1 = room1 + 2;
											room3 = room3 + 2;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat16 == 0)
												{
													eatm16 = 50 * day;

													if (eatm16 <= money)
													{
														eat16 = 1;
														money = money - eatm16;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat16 == 0)
												{
													eatm16 = 100 * day;

													if (eatm16 <= money)
													{
														eat16 = 2;
														money = money - eatm16;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat16 == 0)
												{
													eatm16 = 150 * day;

													if (eatm16 <= money)
													{
														eat16 = 3;
														money = money - eatm16;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm16 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat16 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}



										}
										else if (buy == 2 && money < money16)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else
										{
											cout << "Duzgun daxil edin\n";
										}

									}
									else
									{
										cout << "Bu nomre doludur\n\n";
									}
								}

								else if (room == 18)
								{
									if (room1 != 4 && room1 != 5 && room1 != 6 && room1 != 7 && room2 != 4 && room2 != 5 && room2 != 6 && room2 != 7)
									{
										cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
										cin >> buy;
										cout << "Nece gunluk ?\n";
										cin >> day;
										day1 = day / 10;
										money18 = 400 * (day - day1);
										if (buy == 1 && money >= money18)
										{
											money = money - money18;
											cout << "Siz 18 nomreli otaqi aldiniz\nPulunuzdan " << money18 << "manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room2 = room2 + 4;
											room3 = room3 + 4;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat18 == 0)
												{
													eatm18 = 50 * day;

													if (eatm18 <= money)
													{
														eat18 = 1;
														money = money - eatm18;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat18 == 0)
												{
													eatm18 = 100 * day;

													if (eatm18 <= money)
													{
														eat18 = 2;
														money = money - eatm18;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat18 == 0)
												{
													eatm18 = 150 * day;

													if (eatm18 <= money)
													{
														eat18 = 3;
														money = money - eatm18;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}



										}
										else if (buy == 1 && money < money18)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else if (buy == 2 && money >= money18)
										{
											money = money - (money18 / 2);
											cout << "Siz 18 nomreli otaqi bron etdiniz\nPulunuzdan " << money18 / 2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

											room1 = room1 + 4;
											room3 = room3 + 4;
											while (eat != 0)
											{
												cout << "1 defe yemek ucun 1 basin (50 manat)\n";
												cout << "2 defe yemek ucun 2 basin (100 manat)\n";
												cout << "3 defe yemek ucun 3 basin (150 manat)\n";
												cout << "Geri qayitmaq ucun 0 basin\n";
												cin >> eat;
												if (eat == 1 && eat18 == 0)
												{
													eatm18 = 50 * day;

													if (eatm18 <= money)
													{
														eat18 = 1;
														money = money - eatm18;
														cout << "\nSiz gunde 1 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 1 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 2 && eat18 == 0)
												{
													eatm18 = 100 * day;

													if (eatm18 <= money)
													{
														eat18 = 2;
														money = money - eatm18;
														cout << "\nSiz gunde 2 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 2 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}
												else if (eat == 3 && eat18 == 0)
												{
													eatm18 = 150 * day;

													if (eatm18 <= money)
													{
														eat18 = 3;
														money = money - eatm18;
														cout << "\nSiz gunde 3 defe yemek sifaris etdiniz\n";
														cout << "Pulunuzdan " << eatm18 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

													}
													else
													{
														cout << "\nSizin pulunuz azdir\n";
													}

												}
												else if (eat == 3 && eat18 != 0)
												{
													cout << "\nSiz artiq yemek sifaris vermisinz\n";
												}


											}

										}
										else if (buy == 2 && money < money18)
										{
											cout << "Sizin pulunuz azdir\n";
										}
										else
										{
											cout << "Duzgun daxil edin\n";
										}


									}
									else
									{
										cout << "Bu nomre doludur\n\n";
									}
								}
								else
								{
									cout << "Bele otaq yoxdur ve ya doludur\n";
								}
							}
						}
					}
				}
				else if (room3 == 3 || room3 == 5 || room3 == 6 || room3 == 7)
				{
					cout << "Siz iki ve ya daha cox nomre gotumusunuz. Deyismek olmaz\n";
				}
				else
				{
					cout << "Siz hec bir nomreni goturmemisiniz\n";
				}
			}
		}
		if (room1 == 0 && room2 == 0)
		{
			cout << "\nSiz hec ne elemediniz\n";
		}
		if (room1 == 1)
		{
			cout << "\nSiz 13 nomreli otaqi bron etdiniz\n";
			if (eat13 == 1)
			{
				cout << "Gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 2)
			{
				cout << "Gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 3)
			{
				cout << "Gunde 3 defe yemek sifaris verdiniz\n";
			}
			else
			{
				cout << "Siz yemek sifaris vermemisdinz\n";
			}
		}
		if (room2 == 1)
		{
			cout << "\nSiz 13 nomreli otaqi aldiniz\n";
			if (eat13 == 1)
			{
				cout << "Gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 2)
			{
				cout << "Gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 3)
			{
				cout << "Gunde 3 defe yemek sifaris verdiniz\n";
			}
			else
			{
				cout << "Siz yemek sifaris vermemisdinz\n";
			}
		}
		if (room1 == 2)
		{
			cout << "\nSiz 16 nomreli otaqi  bron etdiniz\n";
			if (eat16 == 1)
			{
				cout << "Gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 2)
			{
				cout << "Gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 3)
			{
				cout << "Gunde 3 defe yemek sifaris verdiniz\n";
			}
			else
			{
				cout << "Siz yemek sifaris vermemisdinz\n";
			}
		}
		if (room2 == 2)
		{
			cout << "\nSiz 16 nomreli otaqi  bron etdiniz\n";
			if (eat16 == 1)
			{
				cout << "Gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 2)
			{
				cout << "Gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 3)
			{
				cout << "Gunde 3 defe yemek sifaris verdiniz\n";
			}
			else
			{
				cout << "Siz yemek sifaris vermemisdinz\n";
			}
		}
		if (room1 == 4)
		{
			cout << "\nSiz 18 nomreli otaqi  bron etdiniz\n";
			if (eat18 == 1)
			{
				cout << "Gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 2)
			{
				cout << "Gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 3)
			{
				cout << "Gunde 3 defe yemek sifaris verdiniz\n";
			}
			else
			{
				cout << "Siz yemek sifaris vermemisdinz\n";
			}
		}
		if (room2 == 4)
		{
			cout << "\nSiz 18 nomreli otaqi  bron etdiniz\n";
			if (eat18 == 1)
			{
				cout << "Gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 2)
			{
				cout << "Gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 3)
			{
				cout << "Gunde 3 defe yemek sifaris verdiniz\n";
			}
			else
			{
				cout << "Siz yemek sifaris vermemisdinz\n";
			}
		}
		if (room1 == 3)
		{
			cout << "\nSiz 13 ve 16 ci otagi rezerv etmisiniz\n";
			if (eat13 == 1)
			{
				cout << "\n13 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 2)
			{
				cout << "\n13 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 3)
			{
				cout << "\n13 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 0)
			{
				cout << "Siz 13 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat16 == 1)
			{
				cout << "16 ci otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 2)
			{
				cout << "16 ci otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 3)
			{
				cout << "16 ci otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 0)
			{
				cout << "Siz 16 ci otaq ucun yemek sifaris vermemisdinz\n";
			}
		}
		if (room2 == 3)
		{
			cout << "\nSiz 13 ve 16 ci otagi aldiniz\n";
			if (eat13 == 1)
			{
				cout << "\n13 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 2)
			{
				cout << "\n13 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 3)
			{
				cout << "\n13 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 0)
			{
				cout << "Siz 13 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat16 == 1)
			{
				cout << "16 ci otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 2)
			{
				cout << "16 ci otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 3)
			{
				cout << "16 ci otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 0)
			{
				cout << "Siz 16 ci otaq ucun yemek sifaris vermemisdinz\n";
			}
		}
		if (room2 == 5)
		{
			cout << "\nSiz 13 ve 18 ci otagi aldiniz\n";
			if (eat13 == 1)
			{
				cout << "\n13 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 2)
			{
				cout << "\n13 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 3)
			{
				cout << "\n13 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 0)
			{
				cout << "Siz 13 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat18 == 1)
			{
				cout << "18 ci otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 2)
			{
				cout << "18 ci otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 3)
			{
				cout << "18 ci otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 0)
			{
				cout << "Siz 18 ci otaq ucun yemek sifaris vermemisdinz\n";
			}
		}
		if (room1 == 5)
		{
			cout << "\nSiz 13 ve 18 ci otagi rezerv etmisinz\n";
			if (eat13 == 1)
			{
				cout << "\n13 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 2)
			{
				cout << "\n13 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 3)
			{
				cout << "\n13 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 0)
			{
				cout << "Siz 13 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat18 == 1)
			{
				cout << "18 ci otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 2)
			{
				cout << "18 ci otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 3)
			{
				cout << "18 ci otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 0)
			{
				cout << "Siz 18 ci otaq ucun yemek sifaris vermemisdinz\n";
			}
		}
		if (room2 == 6)
		{
			cout << "\nSiz 16 ve 18 ci otagi aldiniz\n";
			if (eat16 == 1)
			{
				cout << "\n16 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 2)
			{
				cout << "\n16 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 3)
			{
				cout << "\n16 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 0)
			{
				cout << "Siz 16 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat18 == 1)
			{
				cout << "18 ci otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 2)
			{
				cout << "18 ci otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 3)
			{
				cout << "18 ci otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 0)
			{
				cout << "Siz 18 ci otaq ucun yemek sifaris vermemisdinz\n";
			}
		}
		if (room1 == 6)
		{
			cout << "\nSiz 16 ve 18 ci nomreni rezerv etdiniz\n";
			if (eat16 == 1)
			{
				cout << "\n16 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 2)
			{
				cout << "\n16 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 3)
			{
				cout << "\n16 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 0)
			{
				cout << "Siz 16 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat18 == 1)
			{
				cout << "18 ci otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 2)
			{
				cout << "18 ci otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 3)
			{
				cout << "18 ci otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 0)
			{
				cout << "Siz 18 ci otaq ucun yemek sifaris vermemisdinz\n";
			}
		}
		if (room2 == 7)
		{
			cout << "\nSiz 13 , 16 ve 18 ci otagi aldiniz\n";
			if (eat13 == 1)
			{
				cout << "\n13 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 2)
			{
				cout << "\n13 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 3)
			{
				cout << "\n13 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 0)
			{
				cout << "Siz 13 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat16 == 1)
			{
				cout << "\n16 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 2)
			{
				cout << "\n16 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 3)
			{
				cout << "\n16 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 0)
			{
				cout << "Siz 16 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat18 == 1)
			{
				cout << "18 ci otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 2)
			{
				cout << "18 ci otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 3)
			{
				cout << "18 ci otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 0)
			{
				cout << "Siz 18 ci otaq ucun yemek sifaris vermemisdinz\n";
			}
		}
		if (room1 == 7)
		{
			cout << "\nSiz 13 , 16 ve 18 ci otagi rezerv etmisiniz\n";
			if (eat13 == 1)
			{
				cout << "\n13 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 2)
			{
				cout << "\n13 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 3)
			{
				cout << "\n13 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat13 == 0)
			{
				cout << "Siz 13 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat16 == 1)
			{
				cout << "\n16 cu otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 2)
			{
				cout << "\n16 cu otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 3)
			{
				cout << "\n16 cu otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat16 == 0)
			{
				cout << "Siz 16 cu otaq ucun yemek sifaris vermemisdinz\n";
			}
			if (eat18 == 1)
			{
				cout << "18 ci otaq ucun gunde 1 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 2)
			{
				cout << "18 ci otaq ucun gunde 2 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 3)
			{
				cout << "18 ci otaq ucun gunde 3 defe yemek sifaris verdiniz\n";
			}
			else if (eat18 == 0)
			{
				cout << "Siz 18 ci otaq ucun yemek sifaris vermemisdinz\n";
			}
		}




		if (num == 0) { cout << "\nSagolun\n"; }
	}
}
