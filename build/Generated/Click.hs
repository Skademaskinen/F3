-- This file is auto generated and will be overriden regulary. Please edit `Application/Schema.sql` to change the Types\n"
{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, InstanceSigs, MultiParamTypeClasses, TypeFamilies, DataKinds, TypeOperators, UndecidableInstances, ConstraintKinds, StandaloneDeriving  #-}
{-# OPTIONS_GHC -Wno-unused-imports -Wno-dodgy-imports -Wno-unused-matches #-}
module Generated.Click where
import IHP.HaskellSupport
import IHP.ModelSupport
import CorePrelude hiding (id)
import Data.Time.Clock
import Data.Time.LocalTime
import qualified Data.Time.Calendar
import qualified Data.List as List
import qualified Data.ByteString as ByteString
import qualified Net.IP
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField hiding (Field, name)
import Database.PostgreSQL.Simple.ToField hiding (Field)
import qualified IHP.Controller.Param
import GHC.TypeLits
import Data.UUID (UUID)
import Data.Default
import qualified IHP.QueryBuilder as QueryBuilder
import qualified Data.Proxy
import GHC.Records
import Data.Data
import qualified Data.String.Conversions
import qualified Data.Text.Encoding
import qualified Data.Aeson
import Database.PostgreSQL.Simple.Types (Query (Query), Binary ( .. ))
import qualified Database.PostgreSQL.Simple.Types
import IHP.Job.Types
import IHP.Job.Queue ()
import qualified Control.DeepSeq as DeepSeq
import qualified Data.Dynamic
import Data.Scientific
import Generated.ActualTypes
instance InputValue Click where inputValue = IHP.ModelSupport.recordToInputValue


instance FromRow Click where
    fromRow = do
        id <- field
        ip <- field
        timestamp <- field
        let theRecord = Click id ip timestamp def { originalDatabaseRecord = Just (Data.Dynamic.toDyn theRecord) }
        pure theRecord


type instance GetModelName (Click' ) = "Click"

instance CanCreate Click where
    create :: (?modelContext :: ModelContext) => Click -> IO Click
    create model = do
        sqlQuerySingleRow "INSERT INTO clicks (id, ip, timestamp) VALUES (?, ?, ?) RETURNING id, ip, timestamp" ((model.id, model.ip, model.timestamp))
    createMany [] = pure []
    createMany models = do
        sqlQuery (Query $ "INSERT INTO clicks (id, ip, timestamp) VALUES " <> (ByteString.intercalate ", " (List.map (\_ -> "(?, ?, ?)") models)) <> " RETURNING id, ip, timestamp") (List.concat $ List.map (\model -> [toField (model.id), toField (model.ip), toField (model.timestamp)]) models)

instance CanUpdate Click where
    updateRecord model = do
        sqlQuerySingleRow "UPDATE clicks SET id = ?, ip = ?, timestamp = ? WHERE id = ? RETURNING id, ip, timestamp" ((fieldWithUpdate #id model, fieldWithUpdate #ip model, fieldWithUpdate #timestamp model, model.id))
    updateRecordDiscardResult model = do
        sqlExecDiscardResult "UPDATE clicks SET id = ?, ip = ?, timestamp = ? WHERE id = ?" ((fieldWithUpdate #id model, fieldWithUpdate #ip model, fieldWithUpdate #timestamp model, model.id))

instance Record Click where
    {-# INLINE newRecord #-}
    newRecord = Click def def def  def


instance QueryBuilder.FilterPrimaryKey "clicks" where
    filterWhereId id builder =
        builder |> QueryBuilder.filterWhere (#id, id)
    {-# INLINE filterWhereId #-}


instance SetField "id" (Click' ) (Id' "clicks") where
    {-# INLINE setField #-}
    setField newValue (Click id ip timestamp meta) =
        Click newValue ip timestamp (meta { touchedFields = "id" : touchedFields meta })
instance SetField "ip" (Click' ) Text where
    {-# INLINE setField #-}
    setField newValue (Click id ip timestamp meta) =
        Click id newValue timestamp (meta { touchedFields = "ip" : touchedFields meta })
instance SetField "timestamp" (Click' ) Text where
    {-# INLINE setField #-}
    setField newValue (Click id ip timestamp meta) =
        Click id ip newValue (meta { touchedFields = "timestamp" : touchedFields meta })
instance SetField "meta" (Click' ) MetaBag where
    {-# INLINE setField #-}
    setField newValue (Click id ip timestamp meta) =
        Click id ip timestamp newValue
instance UpdateField "id" (Click' ) (Click' ) (Id' "clicks") (Id' "clicks") where
    {-# INLINE updateField #-}
    updateField newValue (Click id ip timestamp meta) = Click newValue ip timestamp (meta { touchedFields = "id" : touchedFields meta })
instance UpdateField "ip" (Click' ) (Click' ) Text Text where
    {-# INLINE updateField #-}
    updateField newValue (Click id ip timestamp meta) = Click id newValue timestamp (meta { touchedFields = "ip" : touchedFields meta })
instance UpdateField "timestamp" (Click' ) (Click' ) Text Text where
    {-# INLINE updateField #-}
    updateField newValue (Click id ip timestamp meta) = Click id ip newValue (meta { touchedFields = "timestamp" : touchedFields meta })
instance UpdateField "meta" (Click' ) (Click' ) MetaBag MetaBag where
    {-# INLINE updateField #-}
    updateField newValue (Click id ip timestamp meta) = Click id ip timestamp newValue


