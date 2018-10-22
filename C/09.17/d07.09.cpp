#include <iostream>
using namespace std;


int main() {
	int number, attempt = 0, num = 1, pas = 0, pin, list = 1, room = 1, room1 = 0, money, cancel = 1, buy, room2 = 0, day = 0, money1 = 0, room3 = 0, money2 = 0, money4 = 0, change = 1;
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
				if (room3 == 0 )
				{
					cout << "\n13 - 100 manat\n16 - 200 manat\n18 - 400 manat\n";
				}
				else if (room3 == 1 )
				{
					cout << "\n16 - 200 manat\n18 - 400 manat\n";
				}
				else if (room3 == 2 )
				{
					cout << "\n13 - 100 manat\n18 - 400 manat\n";
				}
				else if (room3 == 3 )
				{
					cout << "\n18 - 400 manat\n";
				}
				else if (room3 == 4 )
				{
					cout << "\n13 - 100 manat\n16 - 200 manat\n";
				}
				else if (room3 == 5 )
				{
					cout << "16 - 200 manat\n";
				}
				else if (room3 == 6 )
				{
					cout << "\n13 - 100 manat\n";
				}
				else if (room3 == 7 )
				{
					cout << "\nBos nomre yoxdur\n";
				}
			}
			else if (list == 3)
			{
				room = 1;
				while (room != 0)
				{
					cout << "Bron etmek ve ya almaq  istediyiniz nomreni daxil edin. Bron etdikde nomrenin qiymetinin 50% odemelisiniz.\nGeri qayitmaq ucun 0 daxil edin\n";
					cin >> room;
					if (room == 13)
					{
						if (room1 != 1 && room1 != 3 && room1 != 5 && room2 != 1 && room2 != 3 && room2 != 5 && room1 != 7 && room2 != 7)
						{
							cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
							cin >> buy;
							cout << "Nece gunluk ?";
							cin >> day;
							money1 = 100 * day;
							if (buy == 1 && money >= money1)
							{
						
								money = money - money1;
								cout << "Siz 13 nomreli otaqi aldiniz\nPulunuzdan "<< money1<< " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

								room2 = room2 + 1;
								room3 = room3 + 1;


							}
							else if (buy == 1 && money < money1)
							{
								cout << "Sizin pulunuz azdir\n";
							}
							else if (buy == 2 && money >= money1)
							{
								money2 = money1 / 2;
								money = money - money2;
								cout << "Siz 13 nomreli otaqi bron etdiniz\nPulunuzdan "<< money2 <<" manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

								room1 = room1 + 1;
								room3 = room3 + 1;

							}
							else if (buy == 2 && money < money1)
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
							cout << "Nece gunluk ?";
							cin >> day;
							money1 = 200 * day;
							if (buy == 1 && money >= money1)
							{
								money = money - money1;

								cout << "Siz 16 nomreli otaqi aldiniz\nPulunuzdan "<< money1 <<" manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

								room2 = room2 + 2;
								room3 = room3 + 2;


							}
							else if (buy == 1 && money < money1)
							{
								cout << "Sizin pulunuz azdir\n";
							}
							else if (buy == 2 && money >= money1)
							{
								money2 = money1 / 2;
								money = money - money2;
								cout << "Siz 16 nomreli otaqi bron etdiniz\nPulunuzdan "<< money2 <<" manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

								room1 = room1 + 2;
								room3 = room3 + 2;

							}
							else if (buy == 2 && money < money1)
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
							cout << "Nece gunluk ?";
							cin >> day;
							money1 = 400 * day;
							if (buy == 1 && money >=money1 )
							{
								money = money - money1;
								cout << "Siz 18 nomreli otaqi aldiniz\nPulunuzdan "<<money1 <<"manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

								room2 = room2 + 4;
								room3 = room3 + 4;


							}
							else if (buy == 1 && money < money1)
							{
								cout << "Sizin pulunuz azdir\n";
							}
							else if (buy == 2 && money >= money1)
							{
								money2 = money1 / 2;
								money = money - money2;
								cout << "Siz 18 nomreli otaqi bron etdiniz\nPulunuzdan "<< money2<<" manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

								room1 = room1 + 4;
								room3 = room3 + 4;

							}
							else if (buy == 2 && money < money1)
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
							money4 = money + (money2-25);
							cout << "\nLegv olundu\n";
							cout << "Pulunuz " << money4 << " qederdir";
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
							money4 = money + (money2-50);
							cout << "\nLegv olundu\n";
							cout << "Pulunuz " << money4 << " qederdir";
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
							money4 = money + (money2-100);
							cout << "\nLegv olundu\n";
							cout << "Pulunuz " << money4 << " qederdir";
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
					
					
					while (change != 0)
					{
						
						if (room2 == 1 || room2 == 2 || room2 == 4)
						{
							money = money + money1;
							cout << "Evvelki nomre legv olundu\n";
							cout << "Sizin pulunuz " << money << "qederdir\n";
							cout << "Goturmey istediyiniz nomreni daxil edin\n";
							cin >> room;
						}
						else if (room1 == 1 || room1 == 2 || room1 == 4)
						{
							money = money + money1 / 2;
							cout << "Evvelki nomre legv olundu\n";
							cout << "Sizin pulunuz " << money << "qederdir\n";
							cout << "Goturmey istediyiniz nomreni daxil edin\n";
							cin >> room;
						}
							if (room == 13)
							{
								if (room1 != 1 && room1 != 3 && room1 != 5 && room2 != 1 && room2 != 3 && room2 != 5 && room1 != 7 && room2 != 7)
								{
									cout << "Almaq ucun 1 bron etmek ucun 2 basin\n";
									cin >> buy;
									cout << "Nece gunluk ?";
									cin >> day;
									money1 = 100 * day;
									if (buy == 1 && money >= money1)
									{

										money = money - money1;
										cout << "Siz 13 nomreli otaqi aldiniz\nPulunuzdan " << money1 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										room2 = room2 + 1;
										room3 = room3 + 1;


									}
									else if (buy == 1 && money < money1)
									{
										cout << "Sizin pulunuz azdir\n";
									}
									else if (buy == 2 && money >= money1)
									{
										money2 = money1 / 2;
										money = money - money2;
										cout << "Siz 13 nomreli otaqi bron etdiniz\nPulunuzdan " << money2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										room1 = room1 + 1;
										room3 = room3 + 1;

									}
									else if (buy == 2 && money < money1)
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
									cout << "Nece gunluk ?";
									cin >> day;
									money1 = 200 * day;
									if (buy == 1 && money >= money1)
									{
										money = money - money1;

										cout << "Siz 16 nomreli otaqi aldiniz\nPulunuzdan " << money1 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										room2 = room2 + 2;
										room3 = room3 + 2;


									}
									else if (buy == 1 && money < money1)
									{
										cout << "Sizin pulunuz azdir\n";
									}
									else if (buy == 2 && money >= money1)
									{
										money2 = money1 / 2;
										money = money - money2;
										cout << "Siz 16 nomreli otaqi bron etdiniz\nPulunuzdan " << money2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										room1 = room1 + 2;
										room3 = room3 + 2;

									}
									else if (buy == 2 && money < money1)
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
									cout << "Nece gunluk ?";
									cin >> day;
									money1 = 400 * day;
									if (buy == 1 && money >= money1)
									{
										money = money - money1;
										cout << "Siz 18 nomreli otaqi aldiniz\nPulunuzdan " << money1 << "manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										room2 = room2 + 4;
										room3 = room3 + 4;


									}
									else if (buy == 1 && money < money1)
									{
										cout << "Sizin pulunuz azdir\n";
									}
									else if (buy == 2 && money >= money1)
									{
										money2 = money1 / 2;
										money = money - money2;
										cout << "Siz 18 nomreli otaqi bron etdiniz\nPulunuzdan " << money2 << " manat cixildi\nQalan pulunuz " << money << " qederdir\n\n";

										room1 = room1 + 4;
										room3 = room3 + 4;

									}
									else if (buy == 2 && money < money1)
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
	}
	if (num == 0) cout << "Sagolun\n";
}