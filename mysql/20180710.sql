#错误：You can't specify target table 'xxx' for update in FROM clause 的解决
#不能指定目标表“Tempa”以用于更新FROM子句
#参考：https://www.cnblogs.com/pcheng/p/4950383.html
#中间表查询

UPDATE ss_diagnostic_appointment
SET source = 4
WHERE
	id IN (
		SELECT
			appoint.id
		FROM
			ss_diagnostic_appointment AS appoint
		LEFT JOIN ss_diagnostic_appointment_wx AS wx ON wx.appointment_id = appoint.id
		WHERE
			wx.source = 4
		AND wx.create_time >= '2018-06-10 00:00:00'
		AND wx.create_time <= '2018-07-10 23:00:00'
	);
	
[Err] 1093 - You can't specify target table 'ss_diagnostic_appointment' for update in FROM clause

#解决方式：查询的时候增加一张中间表
UPDATE ss_diagnostic_appointment
SET source = 4
WHERE
	id IN (
		SELECT
			a.appointid
		FROM
			(
				SELECT
					appoint.id AS appointid
				FROM
					ss_diagnostic_appointment AS appoint
				LEFT JOIN ss_diagnostic_appointment_wx AS wx ON wx.appointment_id = appoint.id
				WHERE
					wx.source = 4
				AND wx.create_time >= '2018-06-10 00:00:00'
				AND wx.create_time <= '2018-07-10 23:00:00'
			) a
	);