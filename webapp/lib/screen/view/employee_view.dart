import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/profile_card.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';

class EmployeeDetailView extends StatelessWidget {
  final int id;
  const EmployeeDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                SizeConfig.horizontalSpace(),
                Text(
                  "Çalışan İsmi",
                  style: theme.textTheme.headlineLarge!
                      .copyWith(color: colorScheme.primary),
                ),
                SizeConfig.horizontalSpace(),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: SimpleContainer(
                            title: "Kişisel Bilgiler",
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProfileCard(
                                  tittle: "İsim",
                                ),
                                ProfileCard(
                                  tittle: "E-posta",
                                ),
                                ProfileCard(
                                  tittle: "Doğum Tarihi",
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: SimpleContainer(
                            title: "Diğer Bilgiler",
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProfileCard(
                                  tittle: "Departman",
                                ),
                                ProfileCard(
                                  tittle: "Başlangıç Tarihi",
                                ),
                                ProfileCard(
                                  tittle: "Kalan Yıllık İzin",
                                ),
                              ],
                            )),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 5,
                          child: SimpleContainer(
                            title: "Geçmiş İzinler",
                            child: SizedBox(
                              height: SizeConfig.blockSizeVertical * 26,
                              child: ListWidget(
                                data: [
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                ],
                                titles: [
                                  "Başlangıç Tarihi",
                                  "Bitiş Tarihi",
                                  "Gün Sayısı",
                                  "Onay Durumu",
                                  "İzin tipi"
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 5,
                          child: SimpleContainer(
                            title: "Onay Bekleyen İzinler",
                            child: SizedBox(
                              height: SizeConfig.blockSizeVertical * 26,
                              child: ListWidget(
                                data: [
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                  [
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "15/12/2000",
                                      style: textStyle,
                                    ),
                                    Text(
                                      "3",
                                      style: textStyle,
                                    ),
                                    Icon(Icons.check),
                                    Text(
                                      "Yıllık İzin",
                                      style: textStyle,
                                    )
                                  ],
                                ],
                                titles: [
                                  "Başlangıç Tarihi",
                                  "Bitiş Tarihi",
                                  "Gün Sayısı",
                                  "Onay Durumu",
                                  "İzin tipi"
                                ],
                              ),
                            ),
                          ))
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Container buildCircularImage(
      ColorScheme colorScheme, ThemeData theme, String nameInitials) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.primary, width: 3)),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade400,
        child: Text(nameInitials.toUpperCase(),
            style: theme.textTheme.headlineLarge!
                .copyWith(color: colorScheme.background)),
        radius: SizeConfig.blockSizeHorizontal * 5,
      ),
    );
  }
}
