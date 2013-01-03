using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for Admin
/// </summary>
public class Admin
{
	public Admin()
	{
	
	}
     public DataTable checkLogin(string username,string password)
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text,"select password from AdminUser where LoginName="+username+" and password="+password+" and isactive=1 and isdeleted=0"));
     }
     public int InsertBankData(string horseshoes,string price)
     {
         SqlParameter[] param=new SqlParameter[2];
         param[0]=new SqlParameter("@HorseShoes",horseshoes);
         param[1]=new SqlParameter("@price",price);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "InsertBankdata",param));
     }
     public int UpdateBankData(string BankId, string horseshoes)
     {
         SqlParameter[] param = new SqlParameter[2];
         param[0] = new SqlParameter("@BankId", BankId);
         param[1] = new SqlParameter("@horseshoes", horseshoes);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "UpdateBankData", param));
     }
     public int InsertLevelData(string Level, string Tickets)
     {
         SqlParameter[] param=new SqlParameter[2];
         param[0] = new SqlParameter("@Level", Level);
         param[1] = new SqlParameter("@Tickets", Tickets);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "InsertLeveldata", param));
     }
     public int UpdateLevelData(string LevelId, string Tickets)
     {
         SqlParameter[] param = new SqlParameter[2];
         param[0] = new SqlParameter("@LevelId", LevelId);
         param[1] = new SqlParameter("@Tickets", Tickets);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "UpdateLevelData", param));
     }
     public DataTable getLevel()
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from levels where IsActive=1 And IsDeleted=0"));
     }
     public DataTable getThemes()
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from Themes where IsActive=1 And IsDeleted=0"));
     }
     public DataTable getTicketType()
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from ticketType where IsActive=1 And IsDeleted=0"));
     }
     public int InsertTicketData(string TicketTypeId, string LevelId, string ThemeId, string ticketprice, string scratchprize, string ImageName, string RewardId)
     {
         SqlParameter[] param = new SqlParameter[7];
         param[0] = new SqlParameter("@LevelId", LevelId);
         param[1] = new SqlParameter("@Ticketprice", ticketprice);
         param[2] = new SqlParameter("@Scratchprize", scratchprize);
         param[3] = new SqlParameter("@ThemeId", ThemeId);
         param[4] = new SqlParameter("@TicketTypeId", TicketTypeId);
         param[5] = new SqlParameter("@ImageName", ImageName);
         param[6] = new SqlParameter("@RewardId", RewardId);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "InsertTicketdata", param));
     }

     public int InsertCollectiblesData(string ThemeId, string ColName,  string ImageName1, string ImageName2, string ispurchased,string price)
     {
         SqlParameter[] param = new SqlParameter[6];
         param[0] = new SqlParameter("@ThemeId", ThemeId);
         param[1] = new SqlParameter("@ColName", ColName);
         param[2] = new SqlParameter("@ImageName1", ImageName1);
         param[3] = new SqlParameter("@ImageName2", ImageName2);
         param[4] = new SqlParameter("@ispurchased", ispurchased);
         param[5] = new SqlParameter("@price", price);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "InsertCollectibles", param));
     }
     public int UpdateCollectiblesData(string ColId, string ThemeId, string ColName, string ImageName1, string ImageName2, string ispurchased, string price)
     {
         SqlParameter[] param = new SqlParameter[7];
         param[0] = new SqlParameter("@ThemeId", ThemeId);
         param[1] = new SqlParameter("@ColName", ColName);
         param[2] = new SqlParameter("@ImageName1", ImageName1);
         param[3] = new SqlParameter("@ImageName2", ImageName2);
         param[4] = new SqlParameter("@ispurchased", ispurchased);
         param[5] = new SqlParameter("@price", price);
         param[6] = new SqlParameter("@ColId", ColId);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "UpdateCollectibles", param));
     }
     public int UpdateTicketData(string TicketId,string TicketTypeId, string LevelId, string ThemeId, string ticketprice, string scratchprize, string ImageName, string RewardId)
     {
         SqlParameter[] param = new SqlParameter[8];
         param[0] = new SqlParameter("@LevelId", LevelId);
         param[1] = new SqlParameter("@Ticketprice", ticketprice);
         param[2] = new SqlParameter("@Scratchprize", scratchprize);
         param[3] = new SqlParameter("@ThemeId", ThemeId);
         param[4] = new SqlParameter("@TicketTypeId", TicketTypeId);
         param[5] = new SqlParameter("@ImageName", ImageName);
         param[6] = new SqlParameter("@RewardId", RewardId);
         param[7] = new SqlParameter("@TicketId", TicketId);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "UpdateTicketdata", param));
     }
     public int insertTheme(string LevelId, string ThemeName, string ThemeDesc, string ImageName, string ImageName1)
     {
         SqlParameter[] param = new SqlParameter[5];
         param[0] = new SqlParameter("@ThemeName", ThemeName);
         param[1] = new SqlParameter("@ThemeDesc", ThemeDesc);
         param[2] = new SqlParameter("@ImageName", ImageName);
         param[3] = new SqlParameter("@LevelId", LevelId);
         param[4] = new SqlParameter("@ImageName1", ImageName1);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "insertTheme", param));
     }
     public int UpdateTheme(string ThemeID, string LevelId, string ThemeName, string ThemeDesc, string ImageName, string ImageName1)
     {
         SqlParameter[] param = new SqlParameter[6];
         param[0] = new SqlParameter("@ThemeName", ThemeName);
         param[1] = new SqlParameter("@ThemeDesc", ThemeDesc);
         param[2] = new SqlParameter("@ImageName", ImageName);
         param[3] = new SqlParameter("@ThemeID", ThemeID);
         param[4] = new SqlParameter("@LevelId", LevelId);
         param[5] = new SqlParameter("@ImageName1", ImageName1);
         return (SqlHelper.ExecuteNonQuery(CommandType.StoredProcedure, "UpdateTheme", param));
     }
     public DataTable CheckUserCredential(string username,string password)
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from AdminUser where EMail='"+username+"' and Password='"+password+"' and IsActive=1 and IsDeleted=0"));
     }

     public DataTable getLevelbyLevelId(string LevelId)
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from Levels where LevelId=" + LevelId + " and IsDeleted=0"));
     }

     public DataTable getTicketbyLevelId(string TicketId)
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from Tickets where TicketId=" + TicketId + " and IsDeleted=0"));
     }
     public DataTable getCollectiblebyColId(string ColId)
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from Collectibles where Col_Id=" + ColId + " and IsDeleted=0"));
     }
     public DataTable getBankbyId(string BankId)
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from Bank where Id=" + BankId + " and IsDeleted=0"));
     }
     public DataTable getThemebyId(string ThemeId)
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from Themes where Id=" + ThemeId + " and IsDeleted=0"));
     }
     public DataTable FillLevelGrid()
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from Levels where IsDeleted=0"));
     }
     public DataTable FillTicketGrid()
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select TicketId,TicketType,Levelno,ThemeName,TicketPrice,Reward_Id,T.ImageName,T.IsActive,T.IsDeleted,T.ScratchPrize from Tickets T inner join TicketType TT on T.TicketTypeId=TT.Id  inner join Levels L on T.LevelId=L.LevelId inner join Themes Tm on T.ThemeId=Tm.Id where T.IsDeleted=0"));
     }
     public DataTable FillCollectiblesGrid()
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, " select col_id,ThemeName,colName,C.IsActive,C.IsDeleted from Themes T inner join Collectibles C on T.Id=C.ThemeId where C.IsDeleted=0"));
     }
     public DataTable FillBankGrid()
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select * from Bank where IsDeleted=0"));
     }
     public DataTable FillThemeGrid()
     {
         return (SqlHelper.ExecuteDatatable(CommandType.Text, "select Id,ThemeName,ThemeDesc,ImageName,ImageName1,Levelno,T.IsActive,T.IsDeleted from Themes T inner join Levels L on T.LevelId=L.LevelId where T.IsDeleted=0"));
     }
     public void ChangeStatus(string LevelId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Levels set IsActive=~IsActive where LevelId=" + LevelId + "");
     }
     public void ActivateBankStatus(string BankId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Bank set IsActive=~IsActive where Id=" + BankId + "");
     }
     public void ActivateThemeStatus(string ThemeId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Themes set IsActive=~IsActive where Id=" + ThemeId + "");
     }
     public void ActivateTicketStatus(string TicketId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Tickets set IsActive=~IsActive where TicketId=" + TicketId + "");
     }
     public void ActivateCollectiblesStatus(string ColId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Collectibles set IsActive=~IsActive where Col_Id=" + ColId + "");
     }
     public void DeleteStatus(string LevelId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Levels set IsDeleted=1 where LevelId=" + LevelId + "");
     }
     public void DeleteBankStatus(string BankId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Bank set IsDeleted=1 where Id=" + BankId + "");
     }
     public void DeleteThemeStatus(string ThemeId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Themes set IsDeleted=1 where Id=" + ThemeId + "");
     }
     public void DeleteTicketStatus(string TicketId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Tickets set IsDeleted=1 where TicketId=" + TicketId + "");
     }
     public void DeleteCollectiblesStatus(string ColId)
     {
         SqlHelper.ExecuteNonQuery(CommandType.Text, "update Tickets set IsDeleted=1 where Col_Id=" + ColId + "");
     }
}